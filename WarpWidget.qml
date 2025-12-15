import QtQuick
import Quickshell
import qs.Common
import qs.Widgets
import qs.Services
import qs.Modules.Plugins

PluginComponent {
    id: root

    property bool isConnected: false
    property string statusText: "Click to check"
    property bool isLoading: false

    function updateStatus() {
        isLoading = true
        Proc.runCommand(
            "warpIndicator.status",
            ["warp-cli", "status"],
            (output, exitCode) => {
                if (exitCode === 0) {
                    const lowerOutput = output.toLowerCase()

                    if (lowerOutput.includes("status update: connected")) {
                        isConnected = true
                        statusText = "Connected"
                    } else if (lowerOutput.includes("status update: disconnected") ||
                        lowerOutput.includes("disconnected")) {
                        isConnected = false
                        statusText = "Disconnected"
                        } else if (lowerOutput.includes("connecting")) {
                            isConnected = false
                            statusText = "Connecting..."
                        } else {
                            isConnected = false
                            statusText = "Unknown"
                        }
                } else {
                    isConnected = false
                    statusText = "Error"
                }
                isLoading = false
            },
            100
        )
    }

    function toggleWarp() {
        if (isLoading) return

            const targetState = !isConnected
            const command = isConnected ? ["warp-cli", "disconnect"] : ["warp-cli", "connect"]

            isLoading = true
            isConnected = targetState
            statusText = targetState ? "Connecting..." : "Disconnecting..."

            Proc.runCommand(
                "warpIndicator.toggle",
                command,
                (output, exitCode) => {
                    if (exitCode === 0) {
                        if (typeof ToastService !== "undefined") {
                            ToastService.showInfo(targetState ? "Connecting WARP..." : "Disconnecting WARP...")
                        }
                        // Update nach 1.5 Sekunden
                        Qt.callLater(() => {
                            updateStatusTimer.restart()
                        })
                    } else {
                        if (typeof ToastService !== "undefined") {
                            ToastService.showError("WARP toggle failed")
                        }
                        isConnected = !targetState
                        updateStatus()
                    }
                },
                50
            )
    }

    Timer {
        id: updateStatusTimer
        interval: 1500
        onTriggered: updateStatus()
    }

    // Horizontal bar (top/bottom)
    horizontalBarPill: Component {
        StyledRect {
            implicitWidth: content.width + Theme.spacingM * 2
            implicitHeight: parent.widgetThickness
            width: implicitWidth
            height: implicitHeight
            radius: Theme.cornerRadius
            color: root.isConnected ? Theme.primaryContainer : Theme.surfaceContainerHigh

            Row {
                id: content
                anchors.centerIn: parent
                spacing: Theme.spacingS

                StyledText {
                    id: iconText
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.isConnected ? "🔒" : "🔓"
                    font.pixelSize: Theme.fontSizeMedium
                }

                StyledText {
                    id: labelText
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.isLoading ? "..." : ""
                    color: root.isConnected ? Theme.primary : Theme.surfaceText
                    font.pixelSize: Theme.fontSizeSmall
                    font.weight: Font.Medium
                }
            }

            DankTooltip {
                text: "WARP VPN\nClick to open"
            }
        }
    }

    // Vertical bar (left/right)
    verticalBarPill: Component {
        StyledRect {
            implicitWidth: parent.widgetThickness
            implicitHeight: iconText.implicitHeight + Theme.spacingM * 2
            width: implicitWidth
            height: implicitHeight
            radius: Theme.cornerRadius
            color: root.isConnected ? Theme.primaryContainer : Theme.surfaceContainerHigh

            StyledText {
                id: iconText
                anchors.centerIn: parent
                text: root.isConnected ? "🔒" : "🔓"
                font.pixelSize: Theme.fontSizeMedium
            }

            DankTooltip {
                text: "WARP VPN\nClick to open"
            }
        }
    }

    // Popout window
    popoutContent: Component {
        PopoutComponent {
            headerText: "Cloudflare WARP"
            detailsText: "VPN Connection Status"
            showCloseButton: true

            // Check status when popout opens
            Component.onCompleted: {
                root.updateStatus()
            }

            Column {
                width: parent.width
                spacing: Theme.spacingL

                // Status Display
                StyledRect {
                    width: parent.width
                    height: 100
                    radius: Theme.cornerRadius
                    color: Theme.surfaceContainerHigh

                    Column {
                        anchors.centerIn: parent
                        spacing: Theme.spacingS

                        StyledText {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: root.isLoading ? "⏳" : (root.isConnected ? "🔒" : "🔓")
                            font.pixelSize: 32
                        }

                        StyledText {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: root.statusText
                            font.pixelSize: Theme.fontSizeLarge
                            font.weight: Font.Bold
                            color: root.isConnected ? Theme.primary : Theme.surfaceText
                        }
                    }
                }

                // Toggle Button
                DankButton {
                    width: parent.width
                    height: 48
                    text: root.isLoading ? "Please wait..." : (root.isConnected ? "Disconnect" : "Connect")
                    enabled: !root.isLoading

                    onClicked: {
                        root.toggleWarp()
                    }
                }

                // Info Text
                StyledText {
                    width: parent.width
                    text: root.isConnected
                    ? "Your connection is secured through Cloudflare WARP"
                    : "Click Connect to secure your connection"
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.surfaceVariantText
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }

    popoutWidth: 350
    popoutHeight: 300
}

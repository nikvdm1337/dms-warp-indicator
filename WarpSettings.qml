import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    pluginId: "warpIndicator"

    StyledText {
        width: parent.width
        text: "WARP Indicator Settings"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: "This plugin shows your Cloudflare WARP VPN connection status in the DankBar. Click the indicator to toggle the connection."
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        wrapMode: Text.WordWrap
    }

    ToggleSetting {
        settingKey: "autoConnect"
        label: "Auto-connect on startup"
        description: "Automatically connect to WARP when the shell starts"
        defaultValue: false
    }

    SelectionSetting {
        settingKey: "updateInterval"
        label: "Update Interval"
        description: "How often to check WARP status"
        options: [
            {label: "1 second", value: "1000"},
            {label: "3 seconds", value: "3000"},
            {label: "5 seconds", value: "5000"},
            {label: "10 seconds", value: "10000"}
        ]
        defaultValue: "3000"
    }
}

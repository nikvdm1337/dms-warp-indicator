#!/bin/bash

# WARP Indicator Plugin Installer for DankMaterialShell
# https://github.com/nikvdm1337/dms-warp-indicator

set -e

echo "=========================================="
echo "WARP Indicator Plugin Installer"
echo "=========================================="
echo ""

# Check if DMS config directory exists
DMS_CONFIG_DIR="$HOME/.config/DankMaterialShell"
PLUGIN_DIR="$DMS_CONFIG_DIR/plugins/WarpIndicator"

if [ ! -d "$DMS_CONFIG_DIR" ]; then
    echo "❌ Error: DankMaterialShell config directory not found!"
    echo "   Expected: $DMS_CONFIG_DIR"
    echo "   Please install DankMaterialShell first."
    exit 1
fi

echo "✅ DankMaterialShell config found"

# Check if warp-cli is installed
if ! command -v warp-cli &> /dev/null; then
    echo "⚠️  Warning: warp-cli not found!"
    echo "   Install Cloudflare WARP first:"
    echo "   yay -S cloudflare-warp-bin"
    echo ""
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    echo "✅ warp-cli found"
fi

# Create plugins directory if it doesn't exist
mkdir -p "$DMS_CONFIG_DIR/plugins"

# Remove old installation if exists
if [ -d "$PLUGIN_DIR" ]; then
    echo "⚠️  Old installation found, removing..."
    rm -rf "$PLUGIN_DIR"
fi

# Clone the repository
echo "📦 Installing WARP Indicator plugin..."
git clone https://github.com/nikvdm1337/dms-warp-indicator.git "$PLUGIN_DIR"

# Remove git files from installation
rm -rf "$PLUGIN_DIR/.git"
rm -f "$PLUGIN_DIR/install.sh"
rm -f "$PLUGIN_DIR/.gitignore"

echo ""
echo "=========================================="
echo "✅ Installation complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Restart DankMaterialShell:"
echo "   killall qs && qs -p /usr/share/quickshell/dms/shell.qml"
echo ""
echo "2. Enable the plugin:"
echo "   Settings → Plugins → Enable 'WARP Indicator'"
echo ""
echo "3. Add to your bar:"
echo "   Settings → Dank Bar → Widgets → Add 'WARP Indicator'"
echo ""

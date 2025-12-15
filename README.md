# WARP Indicator for DankMaterialShell

A sleek system tray widget for [Cloudflare WARP](https://1.1.1.1/) VPN integration in [DankMaterialShell](https://github.com/dankdm/DankMaterialShell).

![WARP Indicator Screenshot](screenshot.png)

## Features

- 🔒 **Visual Status Indicator** - See your WARP connection status at a glance
- 🎯 **One-Click Toggle** - Connect/disconnect with a single click
- 🎨 **Material Design** - Seamlessly integrates with DMS theme
- ⚡ **Lightweight** - Only checks status when needed, no background polling
- 📊 **Detailed Popout** - View connection details and control WARP

## Prerequisites

- [DankMaterialShell](https://github.com/dankdm/DankMaterialShell) installed and running
- [Cloudflare WARP](https://pkg.cloudflareclient.com/) client installed

### Install Cloudflare WARP

```bash
# Arch Linux / CachyOS
yay -S cloudflare-warp-bin
# or
paru -S cloudflare-warp-bin

# Enable and start the service
sudo systemctl enable --now warp-svc

# Register WARP (first time only)
warp-cli register
warp-cli set-mode warp
```

## Installation

### Automatic Installation (Recommended)

**One-liner:**
```bash
bash <(curl -s https://raw.githubusercontent.com/nikvdm1337/dms-warp-indicator/main/install.sh)
```

**Or download and run:**
```bash
curl -O https://raw.githubusercontent.com/nikvdm1337/dms-warp-indicator/main/install.sh
./install.sh
```

The install script will:
- ✅ Check if DankMaterialShell is installed
- ✅ Check if warp-cli is available
- ✅ Install the plugin to `~/.config/DankMaterialShell/plugins/WarpIndicator`
- ✅ Provide next steps for activation

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/nikvdm1337/dms-warp-indicator.git \
    ~/.config/DankMaterialShell/plugins/WarpIndicator
```

2. Restart DankMaterialShell:
```bash
killall qs && qs -p /usr/share/quickshell/dms/shell.qml
```

3. Enable the plugin:
   - Open DMS Settings
   - Go to **Plugins**
   - Enable **WARP Indicator**

4. Add to your bar:
   - Go to **Dank Bar → Widgets**
   - Click **Add Widget**
   - Select **WARP Indicator**

## Post-Installation Setup

After running the installer, complete these steps:

1. **Restart DankMaterialShell:**
```bash
killall qs && qs -p /usr/share/quickshell/dms/shell.qml
```

2. **Enable the plugin:**
   - Open DMS Settings (right-click on bar or use settings app)
   - Navigate to **Plugins**
   - Find **WARP Indicator** and toggle it **ON**

3. **Add widget to your bar:**
   - Go to **Settings → Dank Bar → Widgets**
   - Click **Add Widget** button
   - Select **WARP Indicator** from the list
   - Drag to reorder if needed

## Usage

### Bar Widget
- **🛡️ Green** - WARP is connected
- **⚠️ Gray** - WARP is disconnected
- **Click** - Open control popout

### Popout Window
- View current connection status
- Toggle WARP on/off with the Connect/Disconnect button
- See connection details and status messages

### Keyboard Shortcuts
You can also control WARP from terminal:
```bash
warp-cli connect      # Connect to WARP
warp-cli disconnect   # Disconnect from WARP
warp-cli status       # Check current status
```

## Configuration

The widget automatically detects your WARP status using `warp-cli`. No additional configuration needed!

### Customization

If you want to customize the widget appearance, edit:
```bash
~/.config/DankMaterialShell/plugins/WarpIndicator/WarpWidget.qml
```

You can change:
- Icons (currently 🛡️ and ⚠️)
- Colors
- Popout size
- Update intervals

## Troubleshooting

### Widget not appearing
1. Make sure DMS is restarted after installation
2. Check that the plugin is enabled in Settings → Plugins
3. Verify the widget is added in Settings → Dank Bar → Widgets
4. Check the console output for errors:
```bash
killall qs && qs -p /usr/share/quickshell/dms/shell.qml
```

### Status not updating
```bash
# Test warp-cli manually
warp-cli status

# Check if warp-svc is running
systemctl status warp-svc

# Restart warp service if needed
sudo systemctl restart warp-svc
```

### Permission issues
```bash
# Make sure your user can access warp-cli
warp-cli --help

# If permission denied, check service status
sudo systemctl status warp-svc
```

### WARP not connecting
```bash
# Re-register WARP
warp-cli delete
warp-cli register
warp-cli set-mode warp
warp-cli connect
```

### Plugin shows "Error" status
- Verify warp-cli is installed: `which warp-cli`
- Check if warp-svc is running: `systemctl status warp-svc`
- Try manual connect: `warp-cli connect`

## Uninstallation

```bash
# Remove the plugin
rm -rf ~/.config/DankMaterialShell/plugins/WarpIndicator

# Restart DMS
killall qs && qs -p /usr/share/quickshell/dms/shell.qml
```

Then remove the widget from your bar in DMS Settings.

## File Structure

```
WarpIndicator/
├── plugin.json          # Plugin metadata
├── WarpWidget.qml       # Main widget component
├── install.sh           # Installation script
├── README.md            # This file
└── LICENSE              # MIT License
```

## Development

### Testing Changes

After modifying the widget:

```bash
# Restart DMS to see changes
killall qs && qs -p /usr/share/quickshell/dms/shell.qml

# Watch logs for debugging
tail -f /tmp/dms-log.txt | grep -i warp
```

### Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## License

MIT License

Copyright (c) 2024 nikvdm1337

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Credits

- Created for [DankMaterialShell](https://github.com/dankdm/DankMaterialShell)
- Uses [Cloudflare WARP](https://1.1.1.1/) client
- Inspired by the DMS plugin ecosystem

## Changelog

### v1.0.0 (2024-12-15)
- Initial release
- Basic connect/disconnect functionality
- Material Design integration
- On-demand status checking
- Popout control panel

## Support

If you encounter any issues:

1. Check the [Troubleshooting](#troubleshooting) section
2. Search [existing issues](https://github.com/nikvdm1337/dms-warp-indicator/issues)
3. [Open a new issue](https://github.com/nikvdm1337/dms-warp-indicator/issues/new) with:
   - Your system info (OS, DMS version)
   - Steps to reproduce
   - Error messages or logs
   - Screenshots if applicable

## Roadmap

Planned features for future releases:

- [ ] Configurable update intervals
- [ ] Connection statistics
- [ ] Multiple WARP modes support
- [ ] Notification on connection state change
- [ ] Custom icon themes

---

Made with ❤️ for the DankMaterialShell community

**Star ⭐ this repo if you find it useful!**

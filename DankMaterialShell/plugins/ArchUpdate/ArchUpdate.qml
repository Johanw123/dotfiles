import QtQuick
import QtQuick.Controls
import Quickshell
import qs.Common
import qs.Modules.Plugins

PluginComponent {
    id: root

    pillClickAction: () => {
        Quickshell.execDetached(["sh", "-c", "exec \"$HOME/dotfiles/bash/bin/system-update\" --window"]);
    }
    verticalBarPill: horizontalBarPill

    horizontalBarPill: Component {
        Image {
            width: root.iconSize
            height: root.iconSize
            source: Qt.resolvedUrl("archlinux.svg")
            sourceSize.width: width * 2
            sourceSize.height: height * 2
            fillMode: Image.PreserveAspectFit
            ToolTip.visible: hover.hovered
            ToolTip.delay: 500
            ToolTip.text: "Update Arch, AUR and Flatpak packages"

            HoverHandler {
                id: hover
            }

        }

    }

}

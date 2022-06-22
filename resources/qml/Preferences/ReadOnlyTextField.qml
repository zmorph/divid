// Copyright (c) 2016 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.
// Different than the name suggests, it is not always read-only.

import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import UM 1.3 as UM

Item
{
    id: base

    property alias text: textField.text

    signal editingFinished();

    property bool readOnly: false

    width: textField.width
    height: textField.height

    TextField
    {
        id: textField

        enabled: !base.readOnly
        opacity: base.readOnly ? 0.5 : 1.0

        anchors.fill: parent

        onEditingFinished: base.editingFinished()
        Keys.onEnterPressed: base.editingFinished()
        Keys.onReturnPressed: base.editingFinished()
        style: TextFieldStyle {
            selectionColor: UM.Theme.getColor("zmorph_grey")
            selectedTextColor: "white"
            textColor: base.readOnly ? "transparent" : UM.Theme.getColor("zmorph_grey")
            background: Rectangle {
                color: "white"
                border.color: UM.Theme.getColor("secondary_button_shadow")
            }
        }
    }

    Label
    {
        visible: base.readOnly
        text: textField.text

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: textField.__panel ? textField.__panel.leftMargin : 0

        font: UM.Theme.getFont("default")
    }

    SystemPalette { id: palette }
}

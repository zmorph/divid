// Copyright (c) 2015 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

import UM 1.1 as UM

UM.Dialog
{
    width: minimumWidth;
    minimumWidth: 350 * screenScaleFactor;

    height: minimumHeight;
    minimumHeight: 250 * screenScaleFactor;

    title: catalog.i18nc("@title:window", "Convert Image...")

    GridLayout
    {
        UM.I18nCatalog{id: catalog; name: "cura"}
        anchors.fill: parent;
        Layout.fillWidth: true
        columnSpacing: 16 * screenScaleFactor
        rowSpacing: 4 * screenScaleFactor
        columns: 1

        UM.TooltipArea {
            Layout.fillWidth:true
            height: childrenRect.height
            text: catalog.i18nc("@info:tooltip","The maximum distance of each pixel from \"Base.\"")
            Row {
                width: parent.width

                Label {
                    text: catalog.i18nc("@action:label", "Height (mm)")
                    width: 150 * screenScaleFactor
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextField {
                    id: peak_height
                    objectName: "Peak_Height"
                    validator: RegExpValidator {regExp: /^\d{0,3}([\,|\.]\d*)?$/}
                    width: 180 * screenScaleFactor
                    onTextChanged: { manager.onPeakHeightChanged(text) }
                    style: TextFieldStyle {
                        selectionColor: UM.Theme.getColor("zmorph_grey")
                        selectedTextColor: "white"
                        background: Rectangle {
                            border.color: UM.Theme.getColor("zmorph_grey")
                        }
                    }
                }
            }
        }

        UM.TooltipArea {
            Layout.fillWidth:true
            height: childrenRect.height
            text: catalog.i18nc("@info:tooltip","The base height from the build plate in millimeters.")
            Row {
                width: parent.width

                Label {
                    text: catalog.i18nc("@action:label", "Base (mm)")
                    width: 150 * screenScaleFactor
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextField {
                    id: base_height
                    objectName: "Base_Height"
                    validator: RegExpValidator {regExp: /^\d{0,3}([\,|\.]\d*)?$/}
                    width: 180 * screenScaleFactor
                    onTextChanged: { manager.onBaseHeightChanged(text) }
                    style: TextFieldStyle {
                        selectionColor: UM.Theme.getColor("zmorph_grey")
                        selectedTextColor: "white"
                        background: Rectangle {
                            border.color: UM.Theme.getColor("zmorph_grey")
                        }
                    }
                }
            }
        }

        UM.TooltipArea {
            Layout.fillWidth:true
            height: childrenRect.height
            text: catalog.i18nc("@info:tooltip","The width in millimeters on the build plate.")
            Row {
                width: parent.width

                Label {
                    text: catalog.i18nc("@action:label", "Width (mm)")
                    width: 150 * screenScaleFactor
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextField {
                    id: width
                    objectName: "Width"
                    focus: true
                    validator: RegExpValidator {regExp: /^[1-9]\d{0,2}([\,|\.]\d*)?$/}
                    width: 180 * screenScaleFactor
                    onTextChanged: { manager.onWidthChanged(text) }
                    style: TextFieldStyle {
                        selectionColor: UM.Theme.getColor("zmorph_grey")
                        selectedTextColor: "white"
                        background: Rectangle {
                            border.color: UM.Theme.getColor("zmorph_grey")
                        }
                    }
                }
            }
        }

        UM.TooltipArea {
            Layout.fillWidth:true
            height: childrenRect.height
            text: catalog.i18nc("@info:tooltip","The depth in millimeters on the build plate")
            Row {
                width: parent.width

                Label {
                    text: catalog.i18nc("@action:label", "Depth (mm)")
                    width: 150 * screenScaleFactor
                    anchors.verticalCenter: parent.verticalCenter
                }
                TextField {
                    id: depth
                    objectName: "Depth"
                    focus: true
                    validator: RegExpValidator {regExp: /^[1-9]\d{0,2}([\,|\.]\d*)?$/}
                    width: 180 * screenScaleFactor
                    onTextChanged: { manager.onDepthChanged(text) }
                    style: TextFieldStyle {
                        selectionColor: UM.Theme.getColor("zmorph_grey")
                        selectedTextColor: "white"
                        background: Rectangle {
                            border.color: UM.Theme.getColor("zmorph_grey")
                        }
                    }
                }
            }
        }

        UM.TooltipArea {
            Layout.fillWidth:true
            height: childrenRect.height
            text: catalog.i18nc("@info:tooltip","For lithophanes dark pixels should correspond to thicker locations in order to block more light coming through. For height maps lighter pixels signify higher terrain, so lighter pixels should correspond to thicker locations in the generated 3D model.")
            Row {
                width: parent.width

                //Empty label so 2 column layout works.
                Label {
                    text: ""
                    width: 150 * screenScaleFactor
                    anchors.verticalCenter: parent.verticalCenter
                }
                ComboBox {
                    id: lighter_is_higher
                    objectName: "Lighter_Is_Higher"
                    model: [ catalog.i18nc("@item:inlistbox","Darker is higher"), catalog.i18nc("@item:inlistbox","Lighter is higher") ]
                    width: 180 * screenScaleFactor
                    onCurrentIndexChanged: { manager.onImageColorInvertChanged(currentIndex) }
                    style: ComboBoxStyle {
                        selectionColor: UM.Theme.getColor("zmorph_grey")
                        selectedTextColor: "white"
                        background: Rectangle {
                            border.color: UM.Theme.getColor("zmorph_grey")
                            implicitHeight: 25
                            implicitWidth: 25
                        }
                    }
                }
            }
        }

        UM.TooltipArea {
            Layout.fillWidth:true
            height: childrenRect.height
            text: catalog.i18nc("@info:tooltip","For lithophanes a simple logarithmic model for translucency is available. For height maps the pixel values correspond to heights linearly.")
            Row {
                width: parent.width

                Label {
                    text: "Color Model"
                    width: 150 * screenScaleFactor
                    anchors.verticalCenter: parent.verticalCenter
                }
                ComboBox {
                    id: color_model
                    objectName: "ColorModel"
                    model: [ catalog.i18nc("@item:inlistbox","Linear"), catalog.i18nc("@item:inlistbox","Translucency") ]
                    width: 180 * screenScaleFactor
                    onCurrentIndexChanged: { manager.onColorModelChanged(currentIndex) }
                    style: ComboBoxStyle {
                        selectionColor: UM.Theme.getColor("zmorph_grey")
                        selectedTextColor: "white"
                        background: Rectangle {
                            border.color: UM.Theme.getColor("zmorph_grey")
                            implicitHeight: 25
                            implicitWidth: 25
                        }
                    }
                }
            }
        }

        UM.TooltipArea {
            Layout.fillWidth:true
            height: childrenRect.height
            text: catalog.i18nc("@info:tooltip","The percentage of light penetrating a print with a thickness of 1 millimeter. Lowering this value increases the contrast in dark regions and decreases the contrast in light regions of the image.")
            visible: color_model.currentText == catalog.i18nc("@item:inlistbox","Translucency")
            Row {
                width: parent.width

                Label {
                    text: catalog.i18nc("@action:label", "1mm Transmittance (%)")
                    width: 150 * screenScaleFactor
                    anchors.verticalCenter: parent.verticalCenter
                }
                TextField {
                    id: transmittance
                    objectName: "Transmittance"
                    focus: true
                    validator: RegExpValidator {regExp: /^[1-9]\d{0,2}([\,|\.]\d*)?$/}
                    width: 180 * screenScaleFactor
                    onTextChanged: { manager.onTransmittanceChanged(text) }
                    style: TextFieldStyle {
                        selectionColor: UM.Theme.getColor("zmorph_grey")
                        selectedTextColor: "white"
                        background: Rectangle {
                            border.color: UM.Theme.getColor("zmorph_grey")
                        }
                    }
                }
            }
        }

        UM.TooltipArea {
            Layout.fillWidth:true
            height: childrenRect.height
            text: catalog.i18nc("@info:tooltip","The amount of smoothing to apply to the image.")
            Row {
                width: parent.width

                Label {
                    text: catalog.i18nc("@action:label", "Smoothing")
                    width: 150 * screenScaleFactor
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item {
                    width: 180 * screenScaleFactor
                    height: 20 * screenScaleFactor
                    Layout.fillWidth: true

                    Slider {
                        id: smoothing
                        objectName: "Smoothing"
                        maximumValue: 100.0
                        stepSize: 1.0
                        width: 180
                        onValueChanged: { manager.onSmoothingChanged(value) }
                        style: SliderStyle {
                            groove: Rectangle {
                                implicitWidth: 200
                                implicitHeight: 8
                                color: UM.Theme.getColor("zmorph_grey_hover")
                                radius: 8
                                Rectangle {
                                    implicitWidth: styleData.handlePosition
                                    implicitHeight: 8
                                    color: UM.Theme.getColor("zmorph_grey")
                                    radius: 8
                                }
                            }
                            handle: Rectangle {
                                anchors.centerIn: parent
                                color: control.pressed ? "white" : UM.Theme.getColor("zmorph_grey_hover")
                                border.color: UM.Theme.getColor("zmorph_grey")
                                border.width: 2
                                implicitWidth: 16
                                implicitHeight: 16
                                radius: 4
                            }
                        }
                    }
                }
            }
        }
    }

    rightButtons: [
        Button
        {
            id:ok_button
            text: catalog.i18nc("@action:button","OK");
            onClicked: { manager.onOkButtonClicked() }
            enabled: true
            style: ButtonStyle {
                background: Rectangle {
                    border.color: styleData.selected ? UM.Theme.getColor("zmorph_grey_hover") : UM.Theme.getColor("zmorph_grey")
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 1.5 : 1
                    radius: 4
                }
            }
        },
        Button
        {
            id:cancel_button
            text: catalog.i18nc("@action:button","Cancel");
            onClicked: { manager.onCancelButtonClicked() }
            enabled: true
            style: ButtonStyle {
                background: Rectangle {
                    border.color: styleData.selected ? UM.Theme.getColor("zmorph_grey_hover") : UM.Theme.getColor("zmorph_grey")
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 1.5 : 1
                    radius: 4
                }
            }
        }
    ]
}

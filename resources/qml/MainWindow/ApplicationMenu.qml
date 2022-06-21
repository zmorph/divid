// Copyright (c) 2021 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

import UM 1.3 as UM
import Cura 1.1 as Cura

import "../Menus"
import "../Dialogs"

Item
{
    id: menu
    width: applicationMenu.width
    height: applicationMenu.height
    property alias window: applicationMenu.window

    UM.ApplicationMenu
    {
        id: applicationMenu

        FileMenu { 
            title: catalog.i18nc("@title:menu menubar:toplevel", "&File") 
            style: MenuStyle {
                itemDelegate.label: Label {
                    function replaceText(txt) {
                        var index = txt.indexOf("&");
                        if(index >= 0)
                        txt = txt.replace(txt.substr(index, 2), ("<u>" + txt.substr(index + 1, 1) +"</u>"));
                        return txt;
                    }
                    font: UM.Theme.getFont("default")
                    color: styleData.selected || styleData.open ? "white" : "black"
                    text: replaceText(styleData.text)
                }
                itemDelegate.background: Rectangle {
                    color: styleData.selected || styleData.open ? "#202D35" : "white"
                    radius: styleData.selected ? 3 : 0 
                }
            }            
        }

        Menu
        {
            title: catalog.i18nc("@title:menu menubar:toplevel", "&Edit")

            MenuItem { action: Cura.Actions.undo }
            MenuItem { action: Cura.Actions.redo }
            MenuSeparator { }
            MenuItem { action: Cura.Actions.selectAll }
            MenuItem { action: Cura.Actions.arrangeAll }
            MenuItem { action: Cura.Actions.multiplySelection }
            MenuItem { action: Cura.Actions.deleteSelection }
            MenuItem { action: Cura.Actions.deleteAll }
            MenuItem { action: Cura.Actions.resetAllTranslation }
            MenuItem { action: Cura.Actions.resetAll }
            MenuSeparator { }
            MenuItem { action: Cura.Actions.groupObjects }
            MenuItem { action: Cura.Actions.mergeObjects }
            MenuItem { action: Cura.Actions.unGroupObjects }

            style: MenuStyle {
                itemDelegate.label: Label {
                    function replaceText(txt) {
                        var index = txt.indexOf("&");
                        if(index >= 0)
                        txt = txt.replace(txt.substr(index, 2), ("<u>" + txt.substr(index + 1, 1) +"</u>"));
                        return txt;
                    }
                    font: UM.Theme.getFont("default")
                    color: styleData.selected || styleData.open ? "white" : "black"
                    text: replaceText(styleData.text)
                }
                itemDelegate.background: Rectangle {
                    color: styleData.selected || styleData.open ? "#202D35" : "white"
                    radius: styleData.selected ? 3 : 0 
                }
            }
        }

        ViewMenu { 
            title: catalog.i18nc("@title:menu menubar:toplevel", "&View") 
            style: MenuStyle {
                itemDelegate.label: Label {
                    function replaceText(txt) {
                        var index = txt.indexOf("&");
                        if(index >= 0)
                        txt = txt.replace(txt.substr(index, 2), ("<u>" + txt.substr(index + 1, 1) +"</u>"));
                        return txt;
                    }                    
                    font: UM.Theme.getFont("default")
                    color: styleData.selected || styleData.open ? "white" : "black"
                    text: replaceText(styleData.text)
                }
                itemDelegate.background: Rectangle {
                    color: styleData.selected || styleData.open ? "#202D35" : "white"
                    radius: styleData.selected ? 3 : 0 
                }
            }        
        }

        SettingsMenu
        {
            //On MacOS, don't translate the "Settings" word.
            //Qt moves the "settings" entry to a different place, and if it got renamed can't find it again when it
            //attempts to delete the item upon closing the application, causing a crash.
            //In the new location, these items are translated automatically according to the system's language.
            //For more information, see:
            //- https://doc.qt.io/qt-5/macos-issues.html#menu-bar
            //- https://doc.qt.io/qt-5/qmenubar.html#qmenubar-as-a-global-menu-bar
            title: (Qt.platform.os == "osx") ? "&Settings" : catalog.i18nc("@title:menu menubar:toplevel", "&Settings")
            style: MenuStyle {
                itemDelegate.label: Label {
                    function replaceText(txt) {
                        var index = txt.indexOf("&");
                        if(index >= 0)
                        txt = txt.replace(txt.substr(index, 2), ("<u>" + txt.substr(index + 1, 1) +"</u>"));
                        return txt;
                    }                    
                    font: UM.Theme.getFont("default")
                    color: styleData.selected || styleData.open ? "white" : "black"
                    text: replaceText(styleData.text)
                }
                itemDelegate.background: Rectangle {
                    color: styleData.selected || styleData.open ? "#202D35" : "white"
                    radius: styleData.selected ? 3 : 0 
                }
            }            
        }

        Menu
        {
            id: extensionMenu
            title: catalog.i18nc("@title:menu menubar:toplevel", "E&xtensions")

            Instantiator
            {
                id: extensions
                model: UM.ExtensionModel { }

                Menu
                {
                    id: sub_menu
                    title: model.name;
                    visible: actions != null
                    enabled: actions != null
                    Instantiator
                    {
                        model: actions
                        Loader
                        {
                            property var extensionsModel: extensions.model
                            property var modelText: model.text
                            property var extensionName: name

                            sourceComponent: modelText.trim() == "" ? extensionsMenuSeparator : extensionsMenuItem
                        }

                        onObjectAdded: sub_menu.insertItem(index, object.item)
                        onObjectRemoved: sub_menu.removeItem(object.item)
                    }
                }

                onObjectAdded: extensionMenu.insertItem(index, object)
                onObjectRemoved: extensionMenu.removeItem(object)
            }
            style: MenuStyle {
                itemDelegate.label: Label {
                    function replaceText(txt) {
                        var index = txt.indexOf("&");
                        if(index >= 0)
                        txt = txt.replace(txt.substr(index, 2), ("<u>" + txt.substr(index + 1, 1) +"</u>"));
                        return txt;
                    }                    
                    font: UM.Theme.getFont("default")
                    color: styleData.selected || styleData.open ? "white" : "black"
                    text: replaceText(styleData.text)
                }
                itemDelegate.background: Rectangle {
                    color: styleData.selected || styleData.open ? "#202D35" : "white"
                    radius: styleData.selected ? 3 : 0 
                }
            }            
        }

        Menu
        {
            id: preferencesMenu

            //On MacOS, don't translate the "Preferences" word.
            //Qt moves the "preferences" entry to a different place, and if it got renamed can't find it again when it
            //attempts to delete the item upon closing the application, causing a crash.
            //In the new location, these items are translated automatically according to the system's language.
            //For more information, see:
            //- https://doc.qt.io/qt-5/macos-issues.html#menu-bar
            //- https://doc.qt.io/qt-5/qmenubar.html#qmenubar-as-a-global-menu-bar
            title: (Qt.platform.os == "osx") ? "&Preferences" : catalog.i18nc("@title:menu menubar:toplevel", "P&references")

            MenuItem { action: Cura.Actions.preferences }
            style: MenuStyle {
                itemDelegate.label: Label {
                    function replaceText(txt) {
                        var index = txt.indexOf("&");
                        if(index >= 0)
                        txt = txt.replace(txt.substr(index, 2), ("<u>" + txt.substr(index + 1, 1) +"</u>"));
                        return txt;
                    }                    
                    font: UM.Theme.getFont("default")
                    color: styleData.selected || styleData.open ? "white" : "black"
                    text: replaceText(styleData.text)
                }
                itemDelegate.background: Rectangle {
                    color: styleData.selected || styleData.open ? "#202D35" : "white"
                    radius: styleData.selected ? 3 : 0 
                }
            }            
        }

        Menu
        {
            id: helpMenu
            title: catalog.i18nc("@title:menu menubar:toplevel", "&Help")

            MenuItem { action: Cura.Actions.showProfileFolder }
            MenuItem { action: Cura.Actions.showTroubleshooting}
            MenuItem { action: Cura.Actions.documentation }
            // MenuItem { action: Cura.Actions.reportBug }
            MenuSeparator { }
            // MenuItem { action: Cura.Actions.whatsNew }
            MenuItem { action: Cura.Actions.about }
            style: MenuStyle {
                itemDelegate.label: Label {
                    function replaceText(txt) {
                        var index = txt.indexOf("&");
                        if(index >= 0)
                        txt = txt.replace(txt.substr(index, 2), ("<u>" + txt.substr(index + 1, 1) +"</u>"));
                        return txt;
                    }                    
                    font: UM.Theme.getFont("default")
                    color: styleData.selected || styleData.open ? "white" : "black"
                    text: replaceText(styleData.text)
                }
                itemDelegate.background: Rectangle {
                    color: styleData.selected || styleData.open ? "#202D35" : "white"
                    radius: styleData.selected ? 3 : 0 
                }
            }            
        }
    }

    Component
    {
        id: extensionsMenuItem

        MenuItem
        {
            text: modelText
            onTriggered: extensionsModel.subMenuTriggered(extensionName, modelText)
        }
    }

    Component
    {
        id: extensionsMenuSeparator

        MenuSeparator {}
    }


    // ###############################################################################################
    // Definition of other components that are linked to the menus
    // ###############################################################################################

    WorkspaceSummaryDialog
    {
        id: saveWorkspaceDialog
        property var args
        onYes: UM.OutputDeviceManager.requestWriteToDevice("local_file", PrintInformation.jobName, args)
    }

    MessageDialog
    {
        id: newProjectDialog
        modality: Qt.ApplicationModal
        title: catalog.i18nc("@title:window", "New project")
        text: catalog.i18nc("@info:question", "Are you sure you want to start a new project? This will clear the build plate and any unsaved settings.")
        standardButtons: StandardButton.Yes | StandardButton.No
        icon: StandardIcon.Question
        onYes:
        {
            CuraApplication.resetWorkspace()
            Cura.Actions.resetProfile.trigger()
            UM.Controller.setActiveStage("PrepareStage")
        }
    }

    UM.ExtensionModel
    {
        id: curaExtensions
    }

    // ###############################################################################################
    // Definition of all the connections
    // ###############################################################################################

    Connections
    {
        target: Cura.Actions.newProject
        function onTriggered()
        {
            if(Printer.platformActivity || Cura.MachineManager.hasUserSettings)
            {
                newProjectDialog.visible = true
            }
        }
    }

    // show the Toolbox
    Connections
    {
        target: Cura.Actions.browsePackages
        function onTriggered()
        {
            curaExtensions.callExtensionMethod("Toolbox", "launch")
        }
    }

    // Show the Marketplace dialog at the materials tab
    Connections
    {
        target: Cura.Actions.marketplaceMaterials
        function onTriggered()
        {
            curaExtensions.callExtensionMethod("Toolbox", "launch")
            curaExtensions.callExtensionMethod("Toolbox", "setViewCategoryToMaterials")
        }
    }
}

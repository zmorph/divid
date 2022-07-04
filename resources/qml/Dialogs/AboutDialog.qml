// Copyright (c) 2022 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.2
import QtQuick.Controls 2.9

import UM 1.5 as UM
import Cura 1.5 as Cura

UM.Dialog
{
    id: base

    //: About dialog title
    title: catalog.i18nc("@title:window The argument is the application name.", "About %1").arg(CuraApplication.applicationDisplayName)

    minimumWidth: 500 * screenScaleFactor
    minimumHeight: 700 * screenScaleFactor
    width: minimumWidth
    height: minimumHeight

    Rectangle
    {
        id: header
        width: parent.width + 2 * margin // margin from Dialog.qml
        height: childrenRect.height + topPadding

        anchors.top: parent.top
        anchors.topMargin: -margin
        anchors.horizontalCenter: parent.horizontalCenter

        property real topPadding: UM.Theme.getSize("wide_margin").height

        color: UM.Theme.getColor("main_window_header_background")

        Image
        {
            id: logo
            width: (base.minimumWidth * 0.85) | 0
            height: (width * (UM.Theme.getSize("logo").height / UM.Theme.getSize("logo").width)) | 0
            source: UM.Theme.getImage("logo")
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit

            anchors.top: parent.top
            anchors.topMargin: parent.topPadding
            anchors.horizontalCenter: parent.horizontalCenter

            UM.I18nCatalog{id: catalog; name: "cura"}
        }

        UM.Label
        {
            id: version

            text: catalog.i18nc("@label","version: %1").arg(UM.Application.version)
            font: UM.Theme.getFont("large_bold")
            color: UM.Theme.getColor("button_text")
            anchors.right : logo.right
            anchors.top: logo.bottom
            anchors.topMargin: (UM.Theme.getSize("default_margin").height / 2) | 0
        }
    }

    UM.Label
    {
        id: description
        width: parent.width

        //: About dialog application description
        text: catalog.i18nc("@label","End-to-end solution for fused filament 3D printing.")
        font: UM.Theme.getFont("default")
        wrapMode: Text.WordWrap
        anchors.top: header.bottom
        anchors.topMargin: UM.Theme.getSize("default_margin").height
    }

    UM.Label
    {
        id: creditsNotes
        width: parent.width

        //: About dialog application author note
        text: catalog.i18nc("@info:credit","Cura is developed by Ultimaker B.V. in cooperation with the community.\nCura proudly uses the following open source projects:")
        font: UM.Theme.getFont("default")
        wrapMode: Text.WordWrap
        anchors.top: description.bottom
        anchors.topMargin: UM.Theme.getSize("default_margin").height
    }

    ListView
    {
        id: projectsList
        anchors.top: creditsNotes.bottom
        anchors.topMargin: UM.Theme.getSize("default_margin").height
        width: parent.width
        height: base.height - y - (2 * UM.Theme.getSize("default_margin").height + closeButton.height)

        ScrollBar.vertical: UM.ScrollBar
        {
            id: projectsListScrollBar
        }

        delegate: Row
        {
            spacing: UM.Theme.getSize("narrow_margin").width
            UM.Label
            {
                text: "<a href='%1' title='%2'>%2</a>".arg(model.url).arg(model.name)
                width: (projectsList.width * 0.25) | 0
                elide: Text.ElideRight
                onLinkActivated: Qt.openUrlExternally(link)
            }
            UM.Label
            {
                text: model.description
                elide: Text.ElideRight
                width: ((projectsList.width * 0.6) | 0) - parent.spacing * 2 - projectsListScrollBar.width
            }
            UM.Label
            {
                text: model.license
                elide: Text.ElideRight
                width: (projectsList.width * 0.15) | 0
            }
        }
        model: ListModel
        {
            id: projectsModel
        }
        Component.onCompleted:
        {
            projectsModel.append({ name: "Cura", description: catalog.i18nc("@label", "Graphical user interface"), license: "LGPLv3", url: "https://github.com/Ultimaker/Cura" });
            projectsModel.append({ name: "Uranium", description: catalog.i18nc("@label", "Application framework"), license: "LGPLv3", url: "https://github.com/Ultimaker/Uranium" });
            projectsModel.append({ name: "CuraEngine", description: catalog.i18nc("@label", "G-code generator"), license: "AGPLv3", url: "https://github.com/Ultimaker/CuraEngine/blob/main/LICENSE" });
            projectsModel.append({ name: "libArcus", description: catalog.i18nc("@label", "Interprocess communication library"), license: "LGPLv3", url: "https://github.com/Ultimaker/libArcus/blob/main/LICENSE" });
            projectsModel.append({ name: "Python", description: catalog.i18nc("@label", "Programming language"), license: "Python", url: "https://docs.python.org/3/license.html" });
            projectsModel.append({ name: "Qt6", description: catalog.i18nc("@label", "GUI framework"), license: "LGPLv3", url: "https://www.qt.io/" });
            projectsModel.append({ name: "PyQt", description: catalog.i18nc("@label", "GUI framework bindings"), license: "GPL", url: "https://riverbankcomputing.com/software/pyqt" });
            projectsModel.append({ name: "SIP", description: catalog.i18nc("@label", "C/C++ Binding library"), license: "GPL", url: "https://riverbankcomputing.com/software/sip" });
            projectsModel.append({ name: "Protobuf", description: catalog.i18nc("@label", "Data interchange format"), license: "BSD", url: "https://github.com/protocolbuffers/protobuf/blob/main/LICENSE" });
            projectsModel.append({ name: "SciPy", description: catalog.i18nc("@label", "Support library for scientific computing"), license: "BSD-new", url: "https://www.scipy.org/" });
            projectsModel.append({ name: "NumPy", description: catalog.i18nc("@label", "Support library for faster math"), license: "BSD", url: "https://github.com/numpy/numpy/blob/main/LICENSE.txt" });
            projectsModel.append({ name: "NumPy-STL", description: catalog.i18nc("@label", "Support library for handling STL files"), license: "BSD", url: "https://github.com/WoLpH/numpy-stl/blob/develop/LICENSE" });
            projectsModel.append({ name: "Trimesh", description: catalog.i18nc("@label", "Support library for handling triangular meshes"), license: "MIT", url: "https://github.com/mikedh/trimesh/blob/main/LICENSE.md" });
            projectsModel.append({ name: "libSavitar", description: catalog.i18nc("@label", "Support library for handling 3MF files"), license: "LGPLv3", url: "https://github.com/Ultimaker/libSavitar/blob/main/LICENSE" });
            projectsModel.append({ name: "libCharon", description: catalog.i18nc("@label", "Support library for file metadata and streaming"), license: "LGPLv3", url: "https://github.com/Ultimaker/libCharon/blob/master/LICENSE" });
            projectsModel.append({ name: "PySerial", description: catalog.i18nc("@label", "Serial communication library"), license: "Python", url: "https://github.com/pyserial/pyserial/blob/master/LICENSE.txt" });
            projectsModel.append({ name: "python-zeroconf", description: catalog.i18nc("@label", "ZeroConf discovery library"), license: "LGPL", url: "https://github.com/pyserial/pyserial/blob/master/LICENSE.txt" });
            projectsModel.append({ name: "Clipper", description: catalog.i18nc("@label", "Polygon clipping library"), license: "Boost", url: "https://www.boost.org/LICENSE_1_0.txt" });
            projectsModel.append({ name: "Pyclipper", description: catalog.i18nc("@label", "Python bindings for Clipper"), license: "MIT", url: "https://github.com/fonttools/pyclipper" });
            projectsModel.append({ name: "mypy", description: catalog.i18nc("@Label", "Static type checker for Python"), license: "MIT", url: "https://github.com/python/mypy/blob/master/LICENSE" });
            projectsModel.append({ name: "certifi", description: catalog.i18nc("@Label", "Root Certificates for validating SSL trustworthiness"), license: "MPL", url: "https://github.com/certifi/python-certifi/blob/master/LICENSE" });
            projectsModel.append({ name: "cryptography", description: catalog.i18nc("@Label", "Root Certificates for validating SSL trustworthiness"), license: "APACHE and BSD", url: "https://github.com/pyca/cryptography/blob/main/LICENSE" });
            projectsModel.append({ name: "Sentry", description: catalog.i18nc("@Label", "Python Error tracking library"), license: "BSD 2-Clause 'Simplified'", url: "https://github.com/getsentry/sentry-python/blob/master/LICENSE" });
            projectsModel.append({ name: "libnest2d", description: catalog.i18nc("@label", "Polygon packing library, developed by Prusa Research"), license: "LGPL", url: "https://github.com/tamasmeszaros/libnest2d/blob/master/LICENSE.txt" });
            projectsModel.append({ name: "pynest2d", description: catalog.i18nc("@label", "Python bindings for libnest2d"), license: "LGPL", url: "https://github.com/Ultimaker/pynest2d/blob/main/LICENSE" });
            projectsModel.append({ name: "keyring", description: catalog.i18nc("@label", "Support library for system keyring access"), license: "MIT", url: "https://github.com/jaraco/keyring/blob/main/LICENSE" });
            projectsModel.append({ name: "pywin32", description: catalog.i18nc("@label", "Python extensions for Microsoft Windows"), license: "PSF", url: "https://github.com/mhammond/pywin32/blob/main/Pythonwin/License.txt" });
            projectsModel.append({ name: "Noto Sans", description: catalog.i18nc("@label", "Font"), license: "SIL OFL 1.1", url: "https://github.com/google/fonts/blob/main/ofl/notosans/OFL.txt" });
            projectsModel.append({ name: "Font-Awesome-SVG-PNG", description: catalog.i18nc("@label", "SVG icons"), license: "For Font-Awesome-SVG-PNG: MIT, For the Font Awesome font: SIL OFL 1.1", url: "https://github.com/Rush/Font-Awesome-SVG-PNG/blob/master/LICENSE" });
            projectsModel.append({ name: "AppImageKit", description: catalog.i18nc("@label", "Linux cross-distribution application deployment"), license: "MIT", url: "https://github.com/AppImage/AppImageKit/blob/master/LICENSE" });
        }
    }

    rightButtons: Cura.TertiaryButton
    {
        //: Close about dialog button
        id: closeButton
        text: catalog.i18nc("@action:button", "Close")
        onClicked: reject()
    }
}

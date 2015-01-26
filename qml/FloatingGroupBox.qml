/**************************************************************************
**
**    Copyright (C) 2013 by Philip Schuchardt
**    www.cavewhere.com
**
**************************************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

Item {
    id: floatingGroupBoxId

    property int margin: 3
    property alias title: titleId.text
    default property alias boxGroupChildren: container.children

    width: childrenRect.width
    height: childrenRect.height


    Style {
        id: style
    }

    Text {
        id: titleId
        z: 1
        anchors.right: boxGroupId.right
        anchors.bottom: boxGroupId.top
        anchors.rightMargin: 5
        font.bold:  true
    }

    ShadowRectangle {
        id: backgroundRect

        color: style.floatingWidgetColor
        radius: style.floatingWidgetRadius
        height: boxGroupId.height + titleId.height + margin
        width: boxGroupId.width + margin * 2
        //        y: groupAreaRect.height / 2.0
    }


    Rectangle {
        id: boxGroupId

        x: margin
        y: titleId.height

        border.width: 1
        radius: style.floatingWidgetRadius
        color: "#00000000"

        width: container.width + margin * 2;
        height: container.height + margin * 2;

        Item {
            id: container
            x: margin
            y: margin
            width: childrenRect.width
            height: childrenRect.height
        }
    }
}

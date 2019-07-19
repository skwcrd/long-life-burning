import 'package:flutter/material.dart'
  show
    FlatButton,
    Brightness,
    ButtonTextTheme,
    MaterialTapTargetSize;
import 'package:flutter/cupertino.dart' show CupertinoDialogAction;
import 'package:flutter/widgets.dart';

import 'widget_base.dart';

abstract class _BaseData {

  _BaseData({
    this.child,
    this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

}

class MaterialDialogActionData extends _BaseData {

  MaterialDialogActionData({
    Widget child,
    VoidCallback onPressed,
    this.widgetKey,
    this.color,
    this.colorBrightness,
    this.disabledColor,
    this.disabledTextColor,
    this.highlightColor,
    this.onHighlightChanged,
    this.padding,
    this.shape,
    this.splashColor,
    this.textColor,
    this.textTheme,
    this.clipBehavior,
    this.materialTapTargetSize,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
  }) : super(
        child: child,
        onPressed: onPressed);

  final Key widgetKey;
  final Color color;
  final Brightness colorBrightness;
  final Color disabledColor;
  final Color disabledTextColor;
  final Color highlightColor;
  final ValueChanged<bool> onHighlightChanged;
  final EdgeInsetsGeometry padding;
  final ShapeBorder shape;
  final Color splashColor;
  final Color textColor;
  final ButtonTextTheme textTheme;
  final Clip clipBehavior;
  final MaterialTapTargetSize materialTapTargetSize;
  final Color focusColor;
  final Color hoverColor;
  final FocusNode focusNode;

}

class CupertinoDialogActionData extends _BaseData {

  CupertinoDialogActionData({
    Widget child,
    VoidCallback onPressed,
    this.isDefaultAction,
    this.isDestructiveAction,
    this.textStyle,
  }) : super(
        child: child,
        onPressed: onPressed);

  final bool isDefaultAction;
  final bool isDestructiveAction;
  final TextStyle textStyle;

}

class PlatformDialogAction extends PlatformWidgetBase<CupertinoDialogAction, FlatButton> {

  final Key widgetKey;
  final Widget child;
  final VoidCallback onPressed;
  final PlatformBuilder<MaterialDialogActionData> android;
  final PlatformBuilder<CupertinoDialogActionData> ios;

  PlatformDialogAction({
    Key key,
    this.widgetKey,
    @required this.child,
    @required this.onPressed,
    this.android,
    this.ios,
  }) : super(key: key);

  @override
  FlatButton createAndroidWidget(BuildContext context) {
    MaterialDialogActionData data;
    if (android != null) {
      data = android(context);
    }
    return FlatButton(
      key: data?.widgetKey ?? widgetKey,
      child: data?.child ?? child,
      onPressed: data?.onPressed ?? onPressed,
      color: data?.color,
      colorBrightness: data?.colorBrightness,
      disabledColor: data?.disabledColor,
      disabledTextColor: data?.disabledTextColor,
      highlightColor: data?.highlightColor,
      onHighlightChanged: data?.onHighlightChanged,
      padding: data?.padding,
      shape: data?.shape,
      splashColor: data?.splashColor,
      textColor: data?.textColor,
      textTheme: data?.textTheme,
      clipBehavior: data?.clipBehavior ?? Clip.none,
      materialTapTargetSize: data?.materialTapTargetSize,
      focusColor: data?.focusColor,
      focusNode: data?.focusNode,
      hoverColor: data?.hoverColor,
    );
  }

  @override
  CupertinoDialogAction createIosWidget(BuildContext context) {
    CupertinoDialogActionData data;
    if (ios != null) {
      data = ios(context);
    }
    return CupertinoDialogAction(
      child: data?.child ?? child,
      isDefaultAction: data?.isDefaultAction ?? false,
      isDestructiveAction: data?.isDestructiveAction ?? false,
      onPressed: data?.onPressed ?? onPressed,
      textStyle: data?.textStyle,
    );
  }
  
}

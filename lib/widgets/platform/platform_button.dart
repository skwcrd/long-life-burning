import 'package:flutter/material.dart'
  show
    MaterialButton,
    FlatButton,
    RaisedButton,
    Brightness,
    ButtonTextTheme,
    MaterialTapTargetSize;
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:flutter/widgets.dart';

import 'widget_base.dart';

abstract class _BaseData {

  _BaseData({
    this.widgetKey,
    this.child,
    this.color,
    this.onPressed,
    this.padding,
    this.disabledColor,
  });

  final Key widgetKey;
  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final Color disabledColor;

}

class MaterialFlatButtonData extends _BaseData {

  MaterialFlatButtonData({
    Key widgetKey,
    Widget child,
    Color color,
    VoidCallback onPressed,
    EdgeInsetsGeometry padding,
    Color disabledColor,
    this.animationDuration,
    this.colorBrightness,
    this.disabledElevation,
    this.disabledTextColor,
    this.elevation,
    this.highlightColor,
    this.highlightElevation,
    this.onHighlightChanged,
    this.shape,
    this.splashColor,
    this.textColor,
    this.textTheme,
    this.clipBehavior,
    this.materialTapTargetSize,
    this.focusElevation,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.hoverElevation,
  }) : super(
        widgetKey: widgetKey,
        child: child,
        color: color,
        onPressed: onPressed,
        padding: padding,
        disabledColor: disabledColor);

  final Duration animationDuration;
  final Brightness colorBrightness;
  final double disabledElevation;
  final Color disabledTextColor;
  final double elevation;
  final Color highlightColor;
  final double highlightElevation;
  final ValueChanged<bool> onHighlightChanged;
  final ShapeBorder shape;
  final Color splashColor;
  final Color textColor;
  final ButtonTextTheme textTheme;
  final Clip clipBehavior;
  final MaterialTapTargetSize materialTapTargetSize;
  final double focusElevation;
  final Color focusColor;
  final Color hoverColor;
  final FocusNode focusNode;
  final double hoverElevation;

}

class MaterialRaisedButtonData extends _BaseData {

  MaterialRaisedButtonData({
    Key widgetKey,
    Widget child,
    Color color,
    VoidCallback onPressed,
    EdgeInsetsGeometry padding,
    Color disabledColor,
    this.animationDuration,
    this.colorBrightness,
    this.disabledElevation,
    this.disabledTextColor,
    this.elevation,
    this.highlightColor,
    this.highlightElevation,
    this.onHighlightChanged,
    this.shape,
    this.splashColor,
    this.textColor,
    this.textTheme,
    this.clipBehavior,
    this.materialTapTargetSize,
    this.focusElevation,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.hoverElevation,
  }) : super(
        widgetKey: widgetKey,
        child: child,
        color: color,
        onPressed: onPressed,
        padding: padding,
        disabledColor: disabledColor);

  final Duration animationDuration;
  final Brightness colorBrightness;
  final double disabledElevation;
  final Color disabledTextColor;
  final double elevation;
  final Color highlightColor;
  final double highlightElevation;
  final ValueChanged<bool> onHighlightChanged;
  final ShapeBorder shape;
  final Color splashColor;
  final Color textColor;
  final ButtonTextTheme textTheme;
  final Clip clipBehavior;
  final MaterialTapTargetSize materialTapTargetSize;
  final double focusElevation;
  final Color focusColor;
  final Color hoverColor;
  final FocusNode focusNode;
  final double hoverElevation;

}

class CupertinoButtonData extends _BaseData {

  CupertinoButtonData({
    Key widgetKey,
    Widget child,
    Color color,
    VoidCallback onPressed,
    EdgeInsetsGeometry padding,
    Color disabledColor,
    this.borderRadius,
    this.minSize,
    this.pressedOpacity,
  }) : super(
        widgetKey: widgetKey,
        child: child,
        color: color,
        onPressed: onPressed,
        padding: padding,
        disabledColor: disabledColor);

  final BorderRadius borderRadius;
  final double minSize;
  final double pressedOpacity;

}

class PlatformButton extends PlatformWidgetBase<CupertinoButton, MaterialButton> {

  final Key widgetKey;
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;
  final Color disabledColor;
  final PlatformBuilder<MaterialRaisedButtonData> android;
  final PlatformBuilder<MaterialFlatButtonData> androidFlat;
  final PlatformBuilder<CupertinoButtonData> ios;

  PlatformButton({
    Key key,
    this.widgetKey,
    this.child,
    this.onPressed,
    this.color,
    this.disabledColor,
    this.padding,
    this.android,
    this.androidFlat,
    this.ios,
  })  : assert(androidFlat == null || android == null),
        super(key: key);

  @override
  MaterialButton createAndroidWidget(BuildContext context) {
    if (androidFlat != null) {
      MaterialFlatButtonData dataFlat = androidFlat(context);
      return FlatButton(
        key: dataFlat?.widgetKey ?? widgetKey,
        child: dataFlat?.child ?? child,
        onPressed: dataFlat?.onPressed ?? onPressed,
        color: dataFlat?.color,
        colorBrightness: dataFlat?.colorBrightness,
        disabledColor: dataFlat?.disabledColor,
        disabledTextColor: dataFlat?.disabledTextColor,
        highlightColor: dataFlat?.highlightColor,
        onHighlightChanged: dataFlat?.onHighlightChanged,
        padding: dataFlat?.padding,
        shape: dataFlat?.shape,
        splashColor: dataFlat?.splashColor,
        textColor: dataFlat?.textColor,
        textTheme: dataFlat?.textTheme,
        clipBehavior: dataFlat?.clipBehavior ?? Clip.none,
        materialTapTargetSize: dataFlat?.materialTapTargetSize,
        focusColor: dataFlat?.focusColor,
        focusNode: dataFlat?.focusNode,
        hoverColor: dataFlat?.hoverColor,
      );
    }
    MaterialRaisedButtonData dataRaised;
    if (android != null) {
      dataRaised = android(context);
    }
    return RaisedButton(
      key: dataRaised?.widgetKey ?? widgetKey,
      child: dataRaised?.child ?? child,
      onPressed: dataRaised?.onPressed ?? onPressed,
      animationDuration: dataRaised?.animationDuration,
      color: dataRaised?.color ?? color,
      colorBrightness: dataRaised?.colorBrightness,
      disabledColor: dataRaised?.disabledColor ?? disabledColor,
      disabledElevation: dataRaised?.disabledElevation,
      disabledTextColor: dataRaised?.disabledTextColor,
      elevation: dataRaised?.elevation,
      highlightColor: dataRaised?.highlightColor,
      highlightElevation: dataRaised?.highlightElevation,
      onHighlightChanged: dataRaised?.onHighlightChanged,
      padding: dataRaised?.padding ?? padding,
      shape: dataRaised?.shape,
      splashColor: dataRaised?.splashColor,
      textColor: dataRaised?.textColor,
      textTheme: dataRaised?.textTheme,
      clipBehavior: dataRaised?.clipBehavior ?? Clip.none,
      materialTapTargetSize: dataRaised?.materialTapTargetSize,
      focusElevation: dataRaised?.focusElevation,
      focusColor: dataRaised?.focusColor,
      hoverColor: dataRaised?.hoverColor,
      focusNode: dataRaised?.focusNode,
      hoverElevation: dataRaised?.hoverElevation,
    );
  }

  @override
  CupertinoButton createIosWidget(BuildContext context) {
    CupertinoButtonData data;
    if (ios != null) {
      data = ios(context);
    }
    return new CupertinoButton(
      key: data?.widgetKey ?? widgetKey,
      child: data?.child ?? child,
      onPressed: data?.onPressed ?? onPressed,
      borderRadius: data?.borderRadius ?? const BorderRadius.all(const Radius.circular(8.0)),
      color: data?.color ?? color,
      minSize: data?.minSize ?? 44.0,
      padding: data?.padding ?? padding,
      pressedOpacity: data?.pressedOpacity ?? 0.1,
      disabledColor: data?.disabledColor ?? disabledColor,
    );
  }

}

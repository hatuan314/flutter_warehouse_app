import 'package:flutter/material.dart';

class ScreenUtil {
  static ScreenUtil _instance;
  static const int defaultWidth = 375;
  static const int defaultHeight = 812;

  /// Size of the phone in UI Design , px
  num uiWidthPx;
  num uiHeightPx;
  BuildContext rootContext;
  GlobalKey<NavigatorState> navigator;

  /// allowFontScaling Specifies whether fonts should scale
  /// to respect Text Size accessibility settings. The default is false.
  bool allowFontScaling;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;

  factory ScreenUtil() {
    return _instance;
  }

  ScreenUtil._();

  static void init(
      BuildContext context, {
        num width = defaultWidth,
        num height = defaultHeight,
        bool allowFontScaling = false,
        GlobalKey<NavigatorState> navigator,
      }) {
    _instance ??= ScreenUtil._();
    _instance.uiWidthPx = width;
    _instance.uiHeightPx = height;
    _instance.allowFontScaling = allowFontScaling;
    _instance.rootContext = context;
    _instance.navigator = navigator;

    try {
      final MediaQueryData mediaQuery = MediaQuery.of(context);
      _mediaQueryData = mediaQuery;
      _pixelRatio = mediaQuery.devicePixelRatio;
      _screenWidth = mediaQuery.size.width;
      _screenHeight = mediaQuery.size.height;
      _statusBarHeight = mediaQuery.padding.top;
      _bottomBarHeight = _mediaQueryData.padding.bottom;
      _textScaleFactor = mediaQuery.textScaleFactor;
    } catch (_) {
      _pixelRatio = 0;
      _screenWidth = 0;
      _screenHeight = 0;
      _statusBarHeight = 0;
      _bottomBarHeight = 0;
      _textScaleFactor = 0;
    }
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  /// The number of font pixels for each logical pixel.
  static double get textScaleFactor => _textScaleFactor;

  /// The size of the media in logical pixels (e.g, the size of the screen).
  static double get pixelRatio => _pixelRatio;

  /// The horizontal extent of this size.
  static double get screenWidthDp => _screenWidth;

  ///The vertical extent of this size. dp
  static double get screenHeightDp => _screenHeight;

  /// The vertical extent of this size. px
  static double get screenWidth => _screenWidth * _pixelRatio;

  /// The vertical extent of this size. px
  static double get screenHeight => _screenHeight * _pixelRatio;

  /// The offset from the top
  static double get statusBarHeight => _statusBarHeight;

  /// The offset from the bottom.
  static double get bottomBarHeight => _bottomBarHeight;

  /// The ratio of the actual dp to the design draft px
  double get scaleWidth => _screenWidth / uiWidthPx;

  double get scaleHeight =>
      (_screenHeight - _statusBarHeight - _bottomBarHeight) / uiHeightPx;

  double get scaleText => scaleWidth;

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  num setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to
  /// achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect,
  ///  or if there is a difference in shape.
  num setHeight(num height) => height * scaleHeight;

  ///Font size adaptation method
  num setSp(num fontSize, {bool allowFontScalingSelf}) =>
      (allowFontScaling || (allowFontScalingSelf ?? false))
          ? (fontSize * scaleText)
          : (fontSize * scaleText) / _textScaleFactor;
}

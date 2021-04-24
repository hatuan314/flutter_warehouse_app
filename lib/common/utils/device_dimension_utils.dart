import 'package:flutter/cupertino.dart';

class DeviceDimension {
  static const double _referenceWidth = 375;
  static const double _referenceHeight = 667;

  static double getProportionalWidth(double actualWidth, double objectWidth) =>
      (actualWidth * objectWidth) / _referenceWidth;

  static double getProportionalHeight(
          double actualHeight, double objectHeight) =>
      (actualHeight * objectHeight) / _referenceHeight;

  static double getDeviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getDeviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getStatusBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double getWidthProportionalToDeviceWidth(
          BuildContext context, double width) =>
      (width * getDeviceWidth(context)) / _referenceWidth;

  static double getHeightProportionalToDeviceHeight(
          BuildContext context, double height) =>
      (height * getDeviceHeight(context)) / _referenceHeight;

  static double getDevicePadding(BuildContext context,
          {double smallDevicePadding, double normalDevicePadding}) =>
      getDeviceWidth(context) < _referenceWidth
          ? smallDevicePadding ?? 8.0
          : normalDevicePadding ?? 16.0;

  static double getDeviceRatio(BuildContext context) =>
      getDeviceWidth(context) / getDeviceHeight(context);
}

class ScreenSize {
  static double iP5SizeWidth = 320;
}

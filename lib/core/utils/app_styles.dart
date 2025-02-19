import 'package:flutter/material.dart';

abstract class AppStyles {
  static TextStyle styleRegular12(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleRegular14(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleRegular16(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleMedium16(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleRegualr18(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleSemiBold16(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w600,
    );
  }
static TextStyle styleItalic16(BuildContext context) {
  return TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontFamily: 'Alexandria',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );
}
  static TextStyle styleSemiBold18(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle sytleLight20(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle styleMedium20(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle styleRegular20(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleSemiBold20(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w600,
    );
  }
static TextStyle styleExtraLight20(BuildContext context) {
  return TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 20),
    fontFamily: 'Alexandria',
    fontWeight: FontWeight.w200,
  );
}
  static TextStyle styleSemiBold22(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 22),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold24(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold28(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 28),
      fontFamily: 'Alexandria',
      fontWeight: FontWeight.w600,
    );
  }
}

// sacleFactor
// responsive font size
// (min , max) fontsize
double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;

  double width = MediaQuery.sizeOf(context).width;
  if (width < 800) {
    return width / 550;
  } else if (width < 1200) {
    return width / 800;
  } else {
    return width / 1920;
  }
}

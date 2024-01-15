import 'package:flutter/material.dart';

/// [ScreenUtils] is a class that provides static methods to get screen
/// related information.
abstract final class ScreenUtils {
  /// [getScreenHeight] returns the height of the screen.
  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  /// [isKeyboardVisible] returns true if the keyboard is visible.
  /// viewInsets.bottom > 0 means that the keyboard is visible.
  static bool isKeyboardVisible(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom > 0;

  /// [getScreenWidth] returns the width of the screen.
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// [getScreenHeightWithoutPadding] returns the height of the screen without
  /// the padding.
  static double screenHeightWithoutPadding(BuildContext context) =>
      screenHeight(context) -
      MediaQuery.paddingOf(context).top -
      MediaQuery.paddingOf(context).bottom;
}

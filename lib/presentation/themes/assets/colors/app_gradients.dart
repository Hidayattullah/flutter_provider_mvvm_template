import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_gradient_color.dart';

class AppGradients {
  static const linearGradient1 = LinearGradient(
    colors: [
      AppGradientColor.color1,
      AppGradientColor.color2,
      AppGradientColor.color3,
      AppGradientColor.color4,
      AppGradientColor.color5,
      AppGradientColor.color6,
      AppGradientColor.color7,
    ],
  );

  static const linearGradient1Vertical = LinearGradient(
    colors: [
      AppGradientColor.color1,
      AppGradientColor.color2,
      AppGradientColor.color3,
      AppGradientColor.color4,
      AppGradientColor.color5,
      AppGradientColor.color6,
      AppGradientColor.color7,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const linearBlue = LinearGradient(
    colors: [AppGradientColor.blue, AppGradientColor.lightBlue],
  );

  static const buttonCoralGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppGradientColor.colorCoral1,
      AppGradientColor.colorCoral2,
    ],
  );

  static const buttonCoralGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppGradientColor.colorCoral21,
      AppGradientColor.colorCoral22,
    ],
  );

  // Gradient biru-merah untuk kondisi "Focused" untuk tombol add to basket
  static const buttonFocusGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppGradientColor.blue, // biru
      AppGradientColor.color7, // merah
    ],
  );

  static const chooseAgentListFade = LinearGradient(
    colors: [
      AppColors.transparent,
      AppColors.white,
      AppColors.white,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.7, 0.9, 1],
  );

  static const chooseMettimeDaysListFade = LinearGradient(
    colors: [
      AppColors.transparent,
      AppColors.black,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.9, 1],
  );
}

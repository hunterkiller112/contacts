import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppStyles {
  static TextStyle font20WhiteSemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: AppColors.white,
  );
  static TextStyle font16WhiteSemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.white,
  );
  static TextStyle font14PrimaryColorSemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.primaryColor,
  );
  static TextStyle font10PrimaryColorSemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    color: AppColors.primaryColor,
  );
}

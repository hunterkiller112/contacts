import 'package:contact/utils/app_colors.dart';
import 'package:contact/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String? Function(String?)? validator;
  TextEditingController controller;
  String hintText;

  CustomTextFormField({
    required this.validator,
    required this.controller,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      cursorColor: AppColors.white,
      style: AppStyles.font16WhiteSemiBold,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyles.font16WhiteSemiBold,
        border: customBorder(),
        enabledBorder: customBorder(),
        focusedBorder: customBorder(),
      ),
    );
  }

  InputBorder customBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.white),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppTextStyle.kLabelTextStyle,
        // ignore: deprecated_member_use
        fillColor: AppColors.kBlueGrey.withOpacity(0.2),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.kBlueGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.kBlueGrey, width: 2),
        ),
        errorStyle: AppTextStyle.kBottemLabelStyle.copyWith(
          color: AppColors.kRedAccentColor,
          fontSize: 12,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.kBlueGrey, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.kBlueGrey, width: 2),
        ),
      ),
    );
  }
}

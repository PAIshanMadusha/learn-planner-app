import 'package:flutter/material.dart';
import 'package:learn_planner/utils/app_colors.dart';
import 'package:learn_planner/utils/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String textLabel;
  final IconData icon;
  final VoidCallback onPressed;
  const CustomButton({
    super.key,
    required this.textLabel,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.kYellowColor),
      ),
      onPressed: onPressed,
      label: Text(
        textLabel,
        style: AppTextStyle.kNormalTextStyle.copyWith(
          color: AppColors.kBlackColor,
        ),
      ),
      icon: Icon(icon, size: 28, color: AppColors.kBlackColor),
    );
  }
}

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isOutlined;
  final bool isLoading;
  final double? width;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
    this.isLoading = false,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final style = isOutlined
        ? OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size.fromHeight(52),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size.fromHeight(52),
          );

    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 2,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: isOutlined ? AppColors.primary : AppColors.white,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: isOutlined ? AppColors.primary : AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );

    return SizedBox(
      width: width,
      child: isOutlined
          ? OutlinedButton(
              style: style,
              onPressed: isLoading ? null : onPressed,
              child: child,
            )
          : ElevatedButton(
              style: style,
              onPressed: isLoading ? null : onPressed,
              child: child,
            ),
    );
  }
}

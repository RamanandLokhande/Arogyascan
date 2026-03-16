import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBack,
      leading: leading,
      backgroundColor: AppColors.primary,
      title: Text(
        title,
        style: AppTextStyles.heading3.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
      iconTheme: const IconThemeData(color: AppColors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

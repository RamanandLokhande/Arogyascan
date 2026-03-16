import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Stack(
      children: [
        child,
        Container(
          color: Colors.black.withAlpha(102),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
          ),
        ),
      ],
    );
  }
}

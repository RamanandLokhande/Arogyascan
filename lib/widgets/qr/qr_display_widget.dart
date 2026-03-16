import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class QrDisplayWidget extends StatelessWidget {
  final String data;
  final double size;
  final String? label;

  const QrDisplayWidget({
    super.key,
    required this.data,
    this.size = 200.0,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final qrData = data.isEmpty ? 'INVALID' : data;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: size,
            backgroundColor: AppColors.white,
          ),
          if (label != null) ...[
            const SizedBox(height: 12),
            Text(
              label!,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ]
        ],
      ),
    );
  }
}

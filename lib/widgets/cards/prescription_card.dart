import 'package:flutter/material.dart';

import '../../models/prescription_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class PrescriptionCard extends StatelessWidget {
  final PrescriptionModel prescription;

  const PrescriptionCard({
    Key? key,
    required this.prescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = prescription.isActive
        ? AppColors.primary
        : AppColors.textSecondary.withAlpha(102);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: borderColor, width: 4),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    prescription.medicineName,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: prescription.isActive
                        ? AppColors.success
                        : AppColors.divider,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    prescription.isActive ? 'Active' : 'Completed',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: prescription.isActive
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${prescription.dosage} • ${prescription.frequency}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Duration: ${prescription.duration}',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

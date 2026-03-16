import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/medical_record_model.dart';
import '../../providers/patient_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../utils/date_formatter.dart';
import '../../widgets/cards/prescription_card.dart';

class RecordDetailScreen extends StatelessWidget {
  const RecordDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final record = ModalRoute.of(context)!.settings.arguments as MedicalRecordModel;
    final provider = context.watch<PatientProvider>();

    final prescriptions = record.prescriptionIds
        .map((id) => provider.prescriptions.firstWhere(
              (p) => p.id == id,
              orElse: () => throw Exception('Prescription not found'),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Visit Details',
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visit Information
            Text(
              'Visit Information',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              color: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoTile(
                      icon: Icons.local_hospital,
                      title: 'Hospital',
                      value: record.hospitalName,
                    ),
                    const Divider(),
                    _buildInfoTile(
                      icon: Icons.person,
                      title: 'Doctor',
                      value: record.doctorName,
                    ),
                    const Divider(),
                    _buildInfoTile(
                      icon: Icons.calendar_today,
                      title: 'Date',
                      value: DateFormatter.format(record.visitDate),
                    ),
                    const Divider(),
                    _buildInfoTile(
                      icon: Icons.medical_information,
                      title: 'Diagnosis',
                      value: record.diagnosis,
                    ),
                    if (record.notes.isNotEmpty) ...[
                      const Divider(),
                      _buildInfoTile(
                        icon: Icons.note,
                        title: 'Notes',
                        value: record.notes,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Prescriptions
            Text(
              'Prescriptions for this Visit',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            if (prescriptions.isEmpty)
              Center(
                child: Text(
                  'No prescriptions for this visit',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              )
            else
              Column(
                children: prescriptions
                    .map((p) => PrescriptionCard(prescription: p))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
      title: Text(
        title,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      subtitle: Text(
        value,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}

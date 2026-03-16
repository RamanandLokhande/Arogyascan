import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/patient_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/cards/medical_record_card.dart';
import '../../widgets/cards/prescription_card.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PatientProvider>();
    final records = provider.medicalRecords;
    final prescriptions = provider.prescriptions;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            'Medical Records',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Visits'),
              Tab(text: 'Prescriptions'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Visits Tab
            records.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.folder_open,
                          size: 60,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No records found',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return MedicalRecordCard(
                        record: record,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/record-detail',
                            arguments: record,
                          );
                        },
                      );
                    },
                  ),

            // Prescriptions Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Active Prescriptions
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withAlpha(26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Active Prescriptions',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...prescriptions
                      .where((p) => p.isActive)
                      .map((p) => PrescriptionCard(prescription: p)),
                  if (prescriptions.where((p) => p.isActive).isEmpty)
                    Center(
                      child: Text(
                        'No active prescriptions',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Past Prescriptions
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Past Prescriptions',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...prescriptions
                      .where((p) => !p.isActive)
                      .map((p) => PrescriptionCard(prescription: p)),
                  if (prescriptions.where((p) => !p.isActive).isEmpty)
                    Center(
                      child: Text(
                        'No past prescriptions',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/patient_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/qr/qr_display_widget.dart';

class QrCardScreen extends StatelessWidget {
  const QrCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PatientProvider>();
    final patient = provider.currentPatient;

    if (patient == null) {
      return const Scaffold(
        body: Center(child: Text('No patient data')),
      );
    }

    final qrData = jsonEncode({
      'id': patient.id,
      'name': patient.fullName,
      'dob': patient.dateOfBirth,
      'blood': patient.bloodGroup,
      'phone': patient.phoneNumber,
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'My Health QR Card',
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_hospital,
                    color: AppColors.white,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ArogyaScan',
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Smart Health Card',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.white.withAlpha(230),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Patient Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          patient.fullName,
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Health ID: ',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        patient.id,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoChip(patient.bloodGroup),
                      const SizedBox(width: 8),
                      _buildInfoChip(patient.gender),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // QR Code Section
            Center(
              child: Column(
                children: [
                  Text(
                    'Scan to access health records',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  QrDisplayWidget(
                    data: qrData,
                    size: 220,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    patient.id,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Instruction Cards
            Row(
              children: [
                Expanded(
                  child: _buildInstructionCard(
                    icon: Icons.local_hospital,
                    title: 'For Doctors',
                    subtitle: 'Scan to view full medical history',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInstructionCard(
                    icon: Icons.local_pharmacy,
                    title: 'For Pharmacy',
                    subtitle: 'Scan to verify prescription',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Share Button
            CustomButton(
              label: 'Share QR Card',
              icon: Icons.share,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('QR Card sharing coming soon!'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInstructionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

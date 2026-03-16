import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/notification_provider.dart';
import '../../providers/patient_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/cards/health_summary_card.dart';
import '../../widgets/cards/medical_record_card.dart';
import '../../widgets/cards/prescription_card.dart';
import '../medical_records/medical_records_screen.dart';
import '../profile/profile_screen.dart';
import '../qr_card/qr_card_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();
    final patientProvider = context.watch<PatientProvider>();

    final pages = [
      _HomeContent(
        patientProvider: patientProvider,
        notificationProvider: notificationProvider,
      ),
      const MedicalRecordsScreen(),
      const QrCardScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_shared),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final PatientProvider patientProvider;
  final NotificationProvider notificationProvider;

  const _HomeContent({
    required this.patientProvider,
    required this.notificationProvider,
  });

  @override
  Widget build(BuildContext context) {
    final patient = patientProvider.currentPatient;
    final records = patientProvider.medicalRecords;
    final prescriptions = patientProvider.prescriptions;
    final emergencyInfo = patientProvider.emergencyInfo;
    final unread = notificationProvider.unreadCount;

    final firstName = patient?.fullName.split(' ').first ?? '';
    final activePrescriptions =
        prescriptions.where((p) => p.isActive).toList(growable: false);
    final allergies = emergencyInfo?.allergies ?? [];

    return Column(
      children: [
        AppBar(
          backgroundColor: AppColors.primary,
          title: const Text('ArogyaScan'),
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifications');
                  },
                  icon: const Icon(Icons.notifications),
                ),
                if (unread > 0)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unread.toString(),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Good Morning, ${firstName.isEmpty ? 'User' : firstName}! 👋',
                        style: AppTextStyles.heading2.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primary,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.badge,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Health ID: ${patient?.id ?? '--'}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: HealthSummaryCard(
                          title: 'Blood Group',
                          value: patient?.bloodGroup ?? '--',
                          icon: Icons.bloodtype,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 120,
                        child: HealthSummaryCard(
                          title: 'Total Visits',
                          value: records.length.toString(),
                          icon: Icons.local_hospital,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 120,
                        child: HealthSummaryCard(
                          title: 'Active Rx',
                          value: activePrescriptions.length.toString(),
                          icon: Icons.medication,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 120,
                        child: HealthSummaryCard(
                          title: 'Allergies',
                          value: allergies.length.toString(),
                          icon: Icons.warning_amber,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Medical Records',
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/medical-records');
                      },
                      child: Text(
                        'View All',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                if (records.isEmpty)
                  Center(
                    child: Column(
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
                else
                  Column(
                    children: records
                        .take(2)
                        .map(
                          (record) => MedicalRecordCard(
                            record: record,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/record-detail',
                                arguments: record,
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Active Prescriptions',
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/medical-records');
                      },
                      child: Text(
                        'View All',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                if (activePrescriptions.isEmpty)
                  Center(
                    child: Text(
                      'No active prescriptions',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                else
                  Column(
                    children: activePrescriptions
                        .map(
                          (prescription) => PrescriptionCard(
                            prescription: prescription,
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB71C1C), Color(0xFFC62828)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.emergency,
                        color: AppColors.white,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Emergency Info Saved',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: Text(
                          'View',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/patient_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/cards/emergency_info_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PatientProvider>();
    final patient = provider.currentPatient;
    final emergencyInfo = provider.emergencyInfo;
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'My Profile',
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/edit-profile');
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: AppColors.white.withAlpha(77),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    patient?.fullName ?? 'User',
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    patient?.email ?? '',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white.withAlpha(230),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    patient?.phoneNumber ?? '',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white.withAlpha(230),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildChip(patient?.bloodGroup ?? '--'),
                      const SizedBox(width: 8),
                      _buildChip(patient?.gender ?? '--'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Personal Info Section
            Text(
              'Personal Information',
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
                    _InfoRow(
                      icon: Icons.calendar_today,
                      label: 'Date of Birth',
                      value: patient?.dateOfBirth ?? '--',
                    ),
                    const Divider(),
                    _InfoRow(
                      icon: Icons.person,
                      label: 'Gender',
                      value: patient?.gender ?? '--',
                    ),
                    const Divider(),
                    _InfoRow(
                      icon: Icons.phone,
                      label: 'Phone',
                      value: patient?.phoneNumber ?? '--',
                    ),
                    const Divider(),
                    _InfoRow(
                      icon: Icons.email,
                      label: 'Email',
                      value: patient?.email ?? '--',
                    ),
                    const Divider(),
                    _InfoRow(
                      icon: Icons.location_on,
                      label: 'Address',
                      value: patient?.address ?? '--',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Emergency Info
            if (emergencyInfo != null) EmergencyInfoCard(info: emergencyInfo),

            const SizedBox(height: 24),

            // Settings
            Text(
              'Settings',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _buildSettingTile(
              icon: Icons.notifications,
              title: 'Notification Settings',
              onTap: () {
                Navigator.pushNamed(context, '/notification-settings');
              },
            ),
            _buildSettingTile(
              icon: Icons.lock,
              title: 'Privacy & Security',
              onTap: () {
                Navigator.pushNamed(context, '/privacy-security');
              },
            ),
            _buildSettingTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                Navigator.pushNamed(context, '/help-support');
              },
            ),
            _buildSettingTile(
              icon: Icons.info_outline,
              title: 'About ArogyaScan',
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),

            const SizedBox(height: 24),

            // Logout
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );

                  if (!mounted) return;

                  if (shouldLogout == true) {
                    provider.logout();
                    navigator.pushNamedAndRemoveUntil(
                      '/login',
                      (route) => false,
                    );
                  }
                },
                child: Text(
                  'Logout',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(51),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tileColor: AppColors.cardBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

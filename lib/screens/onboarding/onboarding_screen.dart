import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _goToRegister() {
    Navigator.pushReplacementNamed(context, '/register');
  }

  void _nextPage() {
    if (_currentPage == 2) {
      _goToRegister();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  children: [
                    _buildPage(
                      icon: Icons.qr_code_2,
                      title: 'Your Digital Health Card',
                      subtitle:
                          'Carry your complete medical history as a smart QR card — no paperwork needed.',
                    ),
                    _buildPage(
                      icon: Icons.medical_information,
                      title: 'Instant Doctor Access',
                      subtitle:
                          'Doctors scan your QR code to instantly access your history and add new records.',
                    ),
                    _buildPage(
                      icon: Icons.notifications_active,
                      title: 'Never Miss a Dose',
                      subtitle:
                          'Get smart reminders for medicines, follow-ups and prescription renewals.',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _goToLogin,
                      child: Text(
                        'Skip',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: WormEffect(
                        dotColor: AppColors.divider,
                        activeDotColor: AppColors.primary,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _nextPage,
                      child: Text(
                        _currentPage == 2 ? 'Get Started' : 'Next',
                        style: AppTextStyles.bodyMedium.copyWith(
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
    );
  }

  Widget _buildPage({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 120,
          color: AppColors.primary,
        ),
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

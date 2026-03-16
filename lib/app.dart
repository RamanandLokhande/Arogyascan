import 'package:flutter/material.dart';

import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/medical_records/record_detail_screen.dart';
import 'screens/notifications/notifications_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'theme/app_colors.dart';

class ArogyaScanApp extends StatelessWidget {
  const ArogyaScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArogyaScan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/record-detail': (context) => const RecordDetailScreen(),
      },
    );
  }
}

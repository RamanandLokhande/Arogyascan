import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/notification_provider.dart';
import 'providers/patient_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PatientProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider()..initSampleNotifications(),
        ),
      ],
      child: const ArogyaScanApp(),
    ),
  );
}


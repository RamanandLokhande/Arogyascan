import 'package:flutter/foundation.dart';

class NotificationProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> notifications = [];

  int get unreadCount =>
      notifications.where((n) => n['isRead'] == false).length;

  void initSampleNotifications() {
    if (notifications.isEmpty) {
      notifications.addAll([
        {
          'title': 'New Prescription Added',
          'body':
              'Dr. Priya Mehta added a new prescription on 12 Nov 2024',
          'time': 'Just now',
          'isRead': false,
        },
        {
          'title': 'Medicine Reminder',
          'body': 'Time to take Paracetamol 500mg (Thrice daily)',
          'time': '10m ago',
          'isRead': false,
        },
        {
          'title': 'Profile Updated',
          'body':
              'Your emergency contact information was updated successfully',
          'time': '1 day ago',
          'isRead': true,
        },
      ]);
      notifyListeners();
    }
  }

  void addNotification(String title, String body) {
    notifications.insert(0, {
      'title': title,
      'body': body,
      'time': 'Just now',
      'isRead': false,
    });
    notifyListeners();
  }

  void markAllRead() {
    for (final notification in notifications) {
      notification['isRead'] = true;
    }
    notifyListeners();
  }
}

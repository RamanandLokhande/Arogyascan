import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/notification_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();
    final notifications = provider.notifications;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Notifications',
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.markAllRead();
            },
            child: Text(
              'Mark all read',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none,
                    size: 60,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No notifications',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final isRead = notification['isRead'] as bool;
                final title = notification['title'] as String;
                final body = notification['body'] as String;
                final time = notification['time'] as String;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isRead
                        ? AppColors.divider
                        : AppColors.primary,
                    child: Icon(
                      isRead
                          ? Icons.notifications_none
                          : Icons.notifications,
                      color: isRead
                          ? AppColors.textSecondary
                          : AppColors.white,
                    ),
                  ),
                  title: Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    body,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  trailing: Text(
                    time,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  tileColor: isRead ? null : AppColors.cardBackground,
                );
              },
            ),
    );
  }
}

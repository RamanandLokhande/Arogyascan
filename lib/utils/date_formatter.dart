import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String format(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatShort(DateTime date) {
    return DateFormat('dd/MM/yy').format(date);
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    }
    final months = (diff.inDays / 30).floor();
    return '$months month${months == 1 ? '' : 's'} ago';
  }
}

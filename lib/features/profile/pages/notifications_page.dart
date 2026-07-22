import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/constants/app_spacing.dart';
import 'package:noorah/l10n/app_localizations.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool prayerNotification = true;
  bool azkarNotification = true;
  bool quranNotification = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/profile');
            }
          },
        ),
        title: Text(
          l10n.notifications,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.notificationSettings,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: AppSpacing.md),

            _notificationTile(
              title: l10n.prayerTimesNotification,
              subtitle: l10n.prayerTimesNotificationDescription,
              value: prayerNotification,
              onChanged: (value) {
                setState(() {
                  prayerNotification = value;
                });
              },
            ),

            _notificationTile(
              title: l10n.dailyAzkarNotification,
              subtitle: l10n.dailyAzkarNotificationDescription,
              value: azkarNotification,
              onChanged: (value) {
                setState(() {
                  azkarNotification = value;
                });
              },
            ),

            _notificationTile(
              title: l10n.dailyQuranNotification,
              subtitle: l10n.dailyQuranNotificationDescription,
              value: quranNotification,
              onChanged: (value) {
                setState(() {
                  quranNotification = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      elevation: 0,

      margin: const EdgeInsets.only(bottom: 12),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: SwitchListTile(
        // ignore: deprecated_member_use
        activeColor: AppColors.primary,

        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),

        subtitle: Text(subtitle),

        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

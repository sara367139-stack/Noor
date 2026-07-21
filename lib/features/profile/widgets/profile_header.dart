// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String location;
  final VoidCallback onEdit;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.location,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final initials = userName.trim().isNotEmpty
        ? userName.trim()[0].toUpperCase()
        : 'N';
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isDark
                    ? [AppColors.primary.withOpacity(0.9), AppColors.primary.withOpacity(0.3)]
                    : [AppColors.primary, AppColors.primary.withOpacity(0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                initials,
                style: AppTextStyles.heading2.copyWith(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            userName.isNotEmpty ? userName : 'Noorah User',
            style: AppTextStyles.heading2.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: theme.dividerColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  size: 18,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    location.isNotEmpty ? location : 'Add your location',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your Daily Islamic Companion',
            style: AppTextStyles.bodyMedium.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.68),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

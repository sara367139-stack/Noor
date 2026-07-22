// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/constants/app_radius.dart';
import 'package:noorah/core/constants/app_spacing.dart';
import 'package:noorah/core/theme/app_text_styles.dart';
import 'package:noorah/l10n/app_localizations.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final displayName = userName.trim();
    final cleanLocation = location.trim();
    final initials = displayName
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: .22),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        initials.isEmpty ? l10n.settings : l10n.personalSettings,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.onPrimary.withValues(alpha: .76),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        displayName,
                        style: AppTextStyles.heading2.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: colorScheme.onPrimary.withValues(alpha: .82),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              cleanLocation,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: colorScheme.onPrimary.withValues(
                                  alpha: .82,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(
                  tooltip: l10n.editProfile,
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _ProfileStat(icon: Icons.menu_book_rounded, label: l10n.quran),
                _ProfileStat(icon: Icons.explore_rounded, label: l10n.qibla),
                _ProfileStat(icon: Icons.auto_awesome_rounded, label: l10n.adhkar),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileStat({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

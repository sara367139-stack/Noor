import 'package:flutter/material.dart';
import 'package:noorah/features/quran/widgets/ayah_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';


class AyahTile extends StatelessWidget {
  final AyahModel ayah;

  const AyahTile({
    super.key,
    required this.ayah,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Text(
              ayah.number.toString(),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              ayah.text,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 22,
                height: 2,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class DhikrCounter extends StatelessWidget {
  final int count;
  final int target;

  const DhikrCounter({
    super.key,
    required this.count,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    final progress = count / target;

    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 250,
            height: 250,
            child: TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0,
                end: progress,
              ),
              duration: const Duration(milliseconds: 350),
              builder: (context, value, child) {
                return CircularProgressIndicator(
                  value: value,
                  strokeWidth: 10,
                  backgroundColor: Theme.of(context).cardColor,
                  valueColor: const AlwaysStoppedAnimation(
                    AppColors.primary,
                  ),
                );
              },
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Text(
                  "$count",
                  key: ValueKey(count),
                  style: AppTextStyles.displayLarge.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "/ $target",
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      // ignore: deprecated_member_use
                      .withOpacity(.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
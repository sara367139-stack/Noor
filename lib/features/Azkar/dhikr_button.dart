import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class DhikrButton extends StatelessWidget {
  final VoidCallback onTap;

  const DhikrButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        width: 170,
        height: 170,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: AppColors.primary.withOpacity(.35),
              blurRadius: 25,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.touch_app,
            size: 70,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
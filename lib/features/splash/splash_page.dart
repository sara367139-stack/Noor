import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/core/user/user_profile_provider.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () async {
      final hasSavedProfile = await UserProfileNotifier.hasSavedProfile();

      if (mounted) {
        context.go(hasSavedProfile ? '/home' : '/setup');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 46, 75),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_rounded,
                size: AppSizes.iconXLarge,
                color: Theme.of(context).colorScheme.onSurface,
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                " AL Noor",
                style: AppTextStyles.displayLarge.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                "Your Daily Islamic Companion",
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/constants/app_radius.dart';
import 'package:noorah/core/constants/app_spacing.dart';
import 'package:noorah/core/constants/app_strings.dart';
import 'package:noorah/core/theme/app_text_styles.dart';
import 'package:noorah/core/user/user_profile_provider.dart';
import 'package:noorah/features/setup/capital_city_field.dart';
import 'package:noorah/l10n/app_localizations.dart';

class UserSetupPage extends ConsumerStatefulWidget {
  const UserSetupPage({super.key});

  @override
  ConsumerState<UserSetupPage> createState() => _UserSetupPageState();
}

class _UserSetupPageState extends ConsumerState<UserSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  bool _isSaving = false;
  bool _didPrefill = false;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    await ref
        .read(userProfileProvider.notifier)
        .save(
          userName: _nameController.text,
          location: _locationController.text,
        );

    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userProfile = ref.watch(userProfileProvider);
    final l10n = AppLocalizations.of(context)!;

    if (!_didPrefill && userProfile.isLoaded) {
      _didPrefill = true;
      _nameController.text = userProfile.userName;
      _locationController.text = userProfile.location;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Icon(
                        Icons.auto_awesome_rounded,
                        color: colorScheme.onPrimary,
                        size: 34,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      l10n.welcomeToApp.replaceAll('AL Noor', AppStrings.appName),
                      style: AppTextStyles.heading1.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.tellUsYourName,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: .68),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.yourName,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.pleaseEnterYourName;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    CapitalCityField(
                      controller: _locationController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: _saveProfile,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    FilledButton.icon(
                      onPressed: _isSaving ? null : _saveProfile,
                      icon: _isSaving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check_rounded),
                      label: Text(_isSaving ? l10n.saving : l10n.confirm),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

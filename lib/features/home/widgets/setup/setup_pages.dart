import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/core/users/user_profile_provider.dart';
import 'package:noorah/features/setup/capital_city_field.dart';
import 'package:noorah/l10n/app_localizations.dart';

class SetupPage extends ConsumerStatefulWidget {
  const SetupPage({super.key});

  @override
  ConsumerState<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends ConsumerState<SetupPage> {
  final nameController = TextEditingController();
  final locationController = TextEditingController();

  bool loading = false;

  Future<void> save() async {
    if (nameController.text.trim().isEmpty ||
        locationController.text.trim().isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pleaseFillAllFields)),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    await ref
        .read(userProfileProvider.notifier)
        .save(userName: nameController.text, location: locationController.text);

    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.welcome)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: l10n.yourName),
            ),

            const SizedBox(height: 20),

            CapitalCityField(controller: locationController, onSubmitted: save),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : save,
                child: loading
                    ? const CircularProgressIndicator()
                    : Text(l10n.confirm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

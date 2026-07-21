import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/core/users/user_profile_provider.dart';
import 'package:noorah/features/setup/capital_city_field.dart';

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
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
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Your Name"),
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
                    : const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

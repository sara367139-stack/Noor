import 'package:flutter/material.dart';
import 'package:noorah/features/profile/pages/profile_service.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  final controller = TextEditingController();
  final ProfileService _profileService = ProfileService();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadName();
  }

  Future<void> loadName() async {
    final snapshot = await _profileService.getProfile();
    final data = snapshot.data();

    if (data != null) {
      controller.text = data['name'] ?? "";
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> saveName() async {
    if (controller.text.trim().isEmpty) return;

    await _profileService.updateName(
      controller.text.trim(),
    );

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Name"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveName,
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
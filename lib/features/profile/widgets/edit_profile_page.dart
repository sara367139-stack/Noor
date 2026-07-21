import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/features/profile/pages/profile_service.dart';

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentLocation;

  const EditProfilePage({
    super.key,
    required this.currentName,
    required this.currentLocation,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileService _profileService = ProfileService();

  late TextEditingController nameController;
  late TextEditingController locationController;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.currentName);

    locationController =
        TextEditingController(text: widget.currentLocation);
  }

  Future<void> save() async {
    setState(() {
      loading = true;
    });

    await _profileService.updateProfile(
      name: nameController.text.trim(),
      location: locationController.text.trim(),
    );

    if (mounted) {
      context.pop(true);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Location",
                prefixIcon: Icon(Icons.location_on),
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: loading ? null : save,

                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
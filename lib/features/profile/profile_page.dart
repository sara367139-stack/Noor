import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:noorah/features/home/widgets/home_bottom_navigation.dart';
import 'package:noorah/features/profile/pages/profile_service.dart';
import 'package:noorah/features/profile/widgets/dark_mode_tile.dart';
import 'package:noorah/features/profile/widgets/profile_header.dart';

import 'package:noorah/features/profile/widgets/profile_tile.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}


class ProfilePageState extends State<ProfilePage> {
  final ProfileService _profileService = ProfileService();

  String name = "";
  String email = "";
  String photoUrl = "";

  bool loading = true;

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image == null) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final ref = FirebaseStorage.instance
        .ref()
        .child("profile_images")
        .child("${user.uid}.jpg");

    if (kIsWeb) {
      final bytes = await image.readAsBytes();
      await ref.putData(bytes);
    } else {
      await ref.putFile(File(image.path));
    }

    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .update({
      "photoUrl": url,
    });

    setState(() {
      photoUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final snapshot = await _profileService.getProfile();

    final data = snapshot.data();

    if (data != null) {
      setState(() {
        name = data['name'] ?? "User";
        email = data['email'] ?? "";
        photoUrl = data['photoUrl'] ?? "";
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      bottomNavigationBar: const HomeBottomNavigation(
        currentIndex: 3,
      ),

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

 ProfileHeader(
  name: name,
  email: email,
  photoUrl: photoUrl,
  onImageTap: pickImage,
),


      const SizedBox(height: 20),

ElevatedButton.icon(
  onPressed: () async {
    final result = await context.push('/edit-name');

    if (result == true) {
      loadProfile();
    }
  },
  icon: const Icon(Icons.edit),
  label: const Text("Edit Name"),
),

// const SizedBox(height: 30),

// const DarkModeTile(),

          const SizedBox(height: 30),

          const DarkModeTile(),

          ProfileTile(
            icon: Icons.language,
            title: "Language",
            onTap: () {
              context.go('/language');
            },
          ),

          ProfileTile(
            icon: Icons.notifications,
            title: "Notifications",
            onTap: () {
              context.go('/notifications');
            },
          ),

          ProfileTile(
            icon: Icons.star,
            title: "Rate App",
            onTap: () {
              context.go('/rate');
            },
          ),

          ProfileTile(
            icon: Icons.info,
            title: "About Noorah",
            onTap: () {
              context.go('/about');
            },
          ),
        ],
      ),
    );
  }
}
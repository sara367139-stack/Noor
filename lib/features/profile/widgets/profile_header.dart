// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:noorah/core/constants/app_colors.dart';

import 'package:noorah/core/theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String location;
  final VoidCallback onEdit;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.location,
    required this.onEdit,
  });

  @override
Widget build(BuildContext context) {
  // ignore: unused_local_variable
  final colorScheme = Theme.of(context).colorScheme;

  return Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 32,
  ),
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 16, 47, 75),
    borderRadius: BorderRadius.circular(28),
    boxShadow: [
      BoxShadow(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(.15),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  ),

  child: Column(
    children: [

      CircleAvatar(
        radius: 45,
        backgroundColor: Colors.white.withOpacity(.15),
        child: Text(
          userName.isNotEmpty
              ? userName[0].toUpperCase()
              : "N",
          style: const TextStyle(
            fontSize: 34,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      const SizedBox(height: 18),

      Text(
        userName,
        style: AppTextStyles.heading1.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 8),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.white70,
            size: 18,
          ),
          const SizedBox(width: 5),
          Text(
            location,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),

      const SizedBox(height: 10),

      Text(
        "Your Daily Islamic Companion",
        style: AppTextStyles.bodySmall.copyWith(
          color: Colors.white60,
        ),
      ),

      const SizedBox(height: 24),

      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onEdit,
          icon: const Icon(Icons.edit_outlined),
          label: const Text("Edit Profile"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    ],
  ),
);
}
}
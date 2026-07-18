import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const CircleAvatar(
  radius: 50,
  backgroundImage: AssetImage(
    "assets/images/profile.png",
  ),
),

        const SizedBox(height: 15),

        Text(
          "Sara Mohamed",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          "Minya, Egypt",
          style: TextStyle(
            // ignore: deprecated_member_use
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
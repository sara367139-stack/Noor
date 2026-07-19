import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String photoUrl;
  final VoidCallback? onImageTap;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.photoUrl,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            GestureDetector(
              onTap: onImageTap,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: photoUrl.isNotEmpty
                    ? NetworkImage(photoUrl)
                    : const AssetImage(
                        "assets/images/profile.png",
                      ) as ImageProvider,
              ),
            ),

            GestureDetector(
              onTap: onImageTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 18,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Text(
          name,
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          email,
          style: TextStyle(
            color: Theme.of(context)
                .colorScheme
                .onSurface
                // ignore: deprecated_member_use
                .withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:noorah/features/home/widgets/home_bottom_navigation.dart';
import 'package:noorah/features/profile/widgets/dark_mode_tile.dart';
import 'package:noorah/features/profile/widgets/profile_header.dart';

import 'package:noorah/features/profile/widgets/profile_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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

          const ProfileHeader(),

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
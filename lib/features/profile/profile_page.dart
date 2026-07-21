import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/core/users/user_profile_provider.dart';


import 'package:noorah/core/user/user_profile_provider.dart';
import 'package:noorah/features/home/widgets/home_bottom_navigation.dart';
import 'package:noorah/features/profile/widgets/dark_mode_tile.dart';
import 'package:noorah/features/profile/widgets/profile_header.dart';

import 'package:noorah/features/profile/widgets/profile_tile.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);

    if (!userProfile.isLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!userProfile.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go('/setup');
      });

      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      bottomNavigationBar: const HomeBottomNavigation(currentIndex: 3),

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          ProfileHeader(
            userName: userProfile.userName,
            location: userProfile.location,
            onEdit: () => context.go('/setup'),
          ),

          const SizedBox(height: 30),

          const DarkModeTile(),

          ProfileTile(
            icon: Icons.language,
            title: "Language",
            onTap: () {
              context.push('/language');
            },
          ),

          ProfileTile(
            icon: Icons.notifications,
            title: "Notifications",
            onTap: () {
              context.push('/notifications');
            },
          ),

          ProfileTile(
            icon: Icons.star,
            title: "Rate App",
            onTap: () {
              context.push('/rate');
            },
          ),

          ProfileTile(
            icon: Icons.info,
            title: "About Noorah",
            onTap: () {
              context.push('/about');
            },
          ),
        ],
      ),
    );
  }
}

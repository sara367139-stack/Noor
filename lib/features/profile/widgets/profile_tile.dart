import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileTile({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 15),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: onTap,
        leading: Icon(icon, color: AppColors.primary),

        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        trailing: Icon(
          Icons.arrow_forward_ios,
          // ignore: deprecated_member_use
          color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
          size: 18,
        ),
      ),
    );
  }
}

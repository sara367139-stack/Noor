import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme_provider.dart';
import '../../../l10n/app_localizations.dart';

class DarkModeTile extends ConsumerWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        leading: Icon(
          Icons.dark_mode,
         color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          l10n.darkMode,
          style: Theme.of(context).textTheme.bodyLarge,
          
        ),
        trailing: Switch(
          value: themeMode == ThemeMode.dark,
         onChanged: (_) {
          
         ref.read(themeModeNotifierProvider.notifier).toggleTheme();
},
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noorah/features/home/widgets/search_provider.dart';

// import '../providers/search_provider.dart';

class SearchSurah extends ConsumerWidget {
  const SearchSurah({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
  style: TextStyle(
    color: Theme.of(context).colorScheme.onSurface,
  ),
  onChanged: (value) {
    ref.read(searchQueryProvider.notifier).updateQuery(value);
  },
  decoration: InputDecoration(
    filled: true,
    fillColor: Theme.of(context).cardColor,

    hintText: "Search Surah...",

    hintStyle: TextStyle(
      color: Theme.of(context)
          .colorScheme
          .onSurface
          // ignore: deprecated_member_use
          .withOpacity(.6),
    ),

    prefixIcon: Icon(
      Icons.search,
      color: Theme.of(context).colorScheme.primary,
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
  ),
)
    );
  }
}
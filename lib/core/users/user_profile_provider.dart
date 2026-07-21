import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  final String userName;
  final String location;
  final bool isLoaded;

  const UserProfile({
    required this.userName,
    required this.location,
    required this.isLoaded,
  });

  const UserProfile.empty()
      : userName = '',
        location = '',
        isLoaded = false;

  bool get isComplete =>
      userName.trim().isNotEmpty &&
      location.trim().isNotEmpty;
}

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier()
      : super(const UserProfile.empty()) {
    load();
  }

  static const _nameKey = 'user_name';
  static const _locationKey = 'user_location';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    state = UserProfile(
      userName: prefs.getString(_nameKey) ?? '',
      location: prefs.getString(_locationKey) ?? '',
      isLoaded: true,
    );
  }

  Future<void> save({
    required String userName,
    required String location,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_nameKey, userName);
    await prefs.setString(_locationKey, location);

    state = UserProfile(
      userName: userName,
      location: location,
      isLoaded: true,
    );
  }

  static Future<bool> hasSavedProfile() async {
    final prefs = await SharedPreferences.getInstance();

    return (prefs.getString(_nameKey)?.isNotEmpty ?? false) &&
        (prefs.getString(_locationKey)?.isNotEmpty ?? false);
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile>(
  (ref) => UserProfileNotifier(),
);
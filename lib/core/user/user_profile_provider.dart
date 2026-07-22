import 'package:cloud_firestore/cloud_firestore.dart';
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

  const UserProfile.empty() : userName = '', location = '', isLoaded = false;

  bool get isComplete =>
      userName.trim().isNotEmpty && location.trim().isNotEmpty;

  UserProfile copyWith({String? userName, String? location, bool? isLoaded}) {
    return UserProfile(
      userName: userName ?? this.userName,
      location: location ?? this.location,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier() : super(const UserProfile.empty()) {
    load();
  }

  static const _userNameKey = 'user_name';
  static const _locationKey = 'user_location';
  static const _profileIdKey = 'profile_id';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    state = UserProfile(
      userName: prefs.getString(_userNameKey)?.trim() ?? '',
      location: prefs.getString(_locationKey)?.trim() ?? '',
      isLoaded: true,
    );
  }

  Future<void> save({
    required String userName,
    required String location,
  }) async {
    final normalizedName = userName.trim();
    final normalizedLocation = location.trim();
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userNameKey, normalizedName);
    await prefs.setString(_locationKey, normalizedLocation);
    await _saveToFirestore(
      prefs: prefs,
      userName: normalizedName,
      location: normalizedLocation,
    );

    state = UserProfile(
      userName: normalizedName,
      location: normalizedLocation,
      isLoaded: true,
    );
  }

  static Future<bool> hasSavedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString(_userNameKey)?.trim() ?? '';
    final location = prefs.getString(_locationKey)?.trim() ?? '';

    return userName.isNotEmpty && location.isNotEmpty;
  }

  Future<void> _saveToFirestore({
    required SharedPreferences prefs,
    required String userName,
    required String location,
  }) async {
    try {
      final profileId =
          prefs.getString(_profileIdKey) ??
          FirebaseFirestore.instance.collection('users').doc().id;

      await prefs.setString(_profileIdKey, profileId);
      await FirebaseFirestore.instance.collection('users').doc(profileId).set({
        'name': userName,
        'location': location,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // Local profile data is enough to keep the app usable offline.
    }
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile>(
      (ref) => UserProfileNotifier(),
    );

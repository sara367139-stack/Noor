import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _firestore.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "location": "",
      "photoUrl": "",
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProfile() async {

  final user = _auth.currentUser;


  if (user == null) {
    throw Exception("No logged in user");
  }


  return await _firestore
      .collection("users")
      .doc(user.uid)
      .get();
}

  Future<void> updateProfile({
    String? name,
    String? location,
    String? photoUrl,
  }) async {
    final user = _auth.currentUser!;

    final Map<String, dynamic> data = {};

    if (name != null) data["name"] = name;
    if (location != null) data["location"] = location;
    if (photoUrl != null) data["photoUrl"] = photoUrl;

    await _firestore
        .collection("users")
        .doc(user.uid)
        .update(data);
  }


Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
}

}
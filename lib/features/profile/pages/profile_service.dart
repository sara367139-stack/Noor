import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // إنشاء بيانات المستخدم بعد التسجيل
  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({
      'name': name,
      'email': email,
      'photoUrl': '',
    });
  }

  // جلب بيانات المستخدم
  Future<DocumentSnapshot<Map<String, dynamic>>> getProfile() async {
    final user = _auth.currentUser;

    // ignore: avoid_print
    print("CURRENT USER UID: ${user?.uid}");

    if (user == null) {
      throw Exception("No user logged in");
    }

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    // ignore: avoid_print
    print("PROFILE DATA: ${doc.data()}");

    return doc;
  }

  // تحديث اسم المستخدم
  Future<void> updateName(String newName) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("No user logged in");
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .update({
      'name': newName,
    });
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noorah/app/app.dart';



import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
try {
  await FirebaseFirestore.instance
      .collection('test')
      .doc('connection')
      .set({
    'time': DateTime.now().toString(),
  });

  // ignore: avoid_print
  print("Firestore Connected.");
} catch (e) {
  // ignore: avoid_print
  print("Firestore Error: $e");
}

  FirebaseFirestore.instance.settings =
      const Settings(
        persistenceEnabled: false,
      );


runApp(
  const ProviderScope(
    child: NoorahApp(),
  ),
);
}

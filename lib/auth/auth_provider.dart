import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noorah/auth/auth_service.dart';


final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});



final authStateProvider = StreamProvider((ref) {

  final auth = ref.watch(authServiceProvider);

  return auth.authStateChanges;

});
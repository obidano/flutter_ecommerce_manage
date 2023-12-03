
import 'abstract_auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  @override
  Map<String, dynamic>? user;

  @override
  Future<void> authenticate(String email, String password) {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  Future<void> createAccount(String email, String password) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<void> deconnecter() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Stream<Map<String, dynamic>?> streamAuthStateChange() {
    // TODO: implement streamAuthState
    throw UnimplementedError();
  }

}


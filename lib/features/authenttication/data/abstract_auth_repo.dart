abstract class AuthRepo {
  Map<String, dynamic>? get user;

  Stream<Map<String, dynamic>?> streamAuthStateChange();

  Future<void> authenticate(String email, String password);

  Future<void> createAccount(String email, String password);

  Future<void> deconnecter();
}
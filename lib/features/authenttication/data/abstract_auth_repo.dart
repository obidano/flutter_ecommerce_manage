import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fake_auth_repo.dart';

abstract class AuthRepo {
  // Map<String, dynamic>? get user;

  // Stream<Map<String, dynamic>?> streamAuthStateChange();

  Future<void> authenticate(String email, String password);

  Future<void> createAccount(String email, String password);

  Future<void> deconnecter();
}

final authRepoProvider = Provider<FakeAuthRepo>((ref) {
  throw UnimplementedError();
});

final connectedProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  var provider=ref.watch(authRepoProvider);
  return provider.getLocalConnectedUser();
});

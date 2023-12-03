import 'package:new_ecommerce_foundations/utils/in_memory_store.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import 'abstract_auth_repo.dart';

class FakeAuthRepo implements AuthRepo {
  final _authState = InMemoryStore<Map<String, dynamic>?>(null);

  @override
  Map<String, dynamic>? get user => _authState.value;

  @override
  Stream<Map<String, dynamic>?> streamAuthStateChange() => _authState.stream;

  @override
  Future<void> authenticate(String email, String password) async {
    if (user == null) {
      _authState.value = {"id": const Uuid().v4(), "email": email};
    }
  }

  @override
  Future<void> createAccount(String email, String password) async {
    if (user == null) {
      _authState.value = {"id": const Uuid().v4(), "email": email};
    }
  }

  @override
  Future<void> deconnecter() async {
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception("Erreur reseau");
    _authState.value=null;
  }

  void dispose()=> _authState.close();
}

final authRepoProvider = Provider<FakeAuthRepo>((ref) {
  final provider= FakeAuthRepo();
  ref.onDispose(() => provider.dispose());
  return provider;

});

final streamAuthStatePRovider =
    StreamProvider.autoDispose<Map<String, dynamic>?>((ref) {
  final repo = ref.watch(authRepoProvider);
  return repo.streamAuthStateChange();
});

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_ecommerce_foundations/features/authenttication/data/fake_auth_repo.dart';

class LoginController extends StateNotifier<AsyncValue<void>> {
  final FakeAuthRepo authRepo;

  LoginController({required this.authRepo})
      :super(const AsyncValue<void>.data(null));

  Future<bool> deconnexion() async {
    try {
      state = const AsyncValue<void>.loading();
      await authRepo.deconnecter();
      state = const AsyncValue<void>.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue<void>.error(e, st);
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}

final loginControllerProvider = StateNotifierProvider.autoDispose<LoginController, AsyncValue<void>>((ref) {
  final repo = ref.watch(authRepoProvider);
  ref.keepAlive();
  return LoginController(authRepo: repo);
});


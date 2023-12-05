import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/abstract_auth_repo.dart';

class LoginController extends StateNotifier<AsyncValue<void>> {
  final AuthRepo authRepo;

  LoginController({required this.authRepo})
      : super(const AsyncValue<void>.data(null));

  Future<bool> deconnexion() async {
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard(() => authRepo.deconnecter());
    return state.hasError == false;
  }

  Future<bool> connexion(String login, String password) async {
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard(() => authRepo.authenticate(login, password));
    // debugPrint("Authentication ${ state.hasError}");
    return state.hasError == false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, AsyncValue<void>>((ref) {
  final repo = ref.watch(authRepoProvider);
  ref.keepAlive();
  return LoginController(authRepo: repo);
});

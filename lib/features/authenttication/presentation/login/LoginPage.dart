import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/features/authenttication/presentation/login/LoginController.dart';
import 'package:new_ecommerce_foundations/routers.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';
import 'package:new_ecommerce_foundations/utils/errorDialog.dart';
import 'package:new_ecommerce_foundations/widgets/MButton.dart';
import 'package:new_ecommerce_foundations/widgets/MImage.dart';
import 'package:new_ecommerce_foundations/widgets/MTextField.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  var emailCtrl = TextEditingController(text: "omotetedan3@gmail.com");
  var passwordCtrl = TextEditingController(text: "dandan");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    ref.listen<AsyncValue<void>>(loginControllerProvider, (previous, next) {
      if (next.hasError) {
        showErrorDialog(context, next.error.toString());
      }
    });

    var state = ref.watch(loginControllerProvider);
    // debugPrint("state loading ${state.isLoading}");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                const MImage(
                  url: "assets/gestion.png",
                  isNetwork: false,
                  height: 170,
                ),
                Text(
                  "Authentification",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                gapH16,
                MTextField(
                    label: "Email",
                    hintText: "Saisir votre adresse mail...",
                    controller: emailCtrl),
                MTextField(
                    label: "Mot de passe",
                    obscureText: true,
                    hintText: "Saisir votre mot de passe...",
                    controller: passwordCtrl),
                gapH24,
                MButton(
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                  text: "Se connecter",
                  isLoading: state.isLoading,
                  onClick: () {
                    _onConnect(state);
                  },
                  mainAxisSize: MainAxisSize.max,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.p48, vertical: Sizes.p20),
                  child: Divider(),
                ),
                MButton(
                  backgroundColor: Colors.transparent,
                  textColor: Colors.black,
                  elevation: 0,
                  text: "Créer un compte",
                  onClick: () {},
                  mainAxisSize: MainAxisSize.max,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onConnect(AsyncValue<void> state) async {
    debugPrint("login loading...${state.isLoading}");
    if (state.isLoading) return;
    var provider = ref.read(loginControllerProvider.notifier);
    var res = await provider.connexion(emailCtrl.text, passwordCtrl.text);

    if (res && context.mounted) {
      context.pushReplacementNamed(Urls.home.name);
    }
  }
}

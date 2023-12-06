import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/features/authenttication/data/user_repo.dart';
import 'package:new_ecommerce_foundations/features/authenttication/presentation/login/LoginController.dart';
import 'package:new_ecommerce_foundations/routers.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';
import 'package:new_ecommerce_foundations/utils/errorDialog.dart';
import 'package:new_ecommerce_foundations/widgets/MButton.dart';
import 'package:new_ecommerce_foundations/widgets/MImage.dart';
import 'package:new_ecommerce_foundations/widgets/MTextField.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  var emailCtrl = TextEditingController(text: "omotetedan3@gmail.com");
  var passwordCtrl = TextEditingController(text: "dandan");
  var confirmPasswordCtrl = TextEditingController(text: "dandan");
  var phoneCtrl = TextEditingController(text: "2438989");
  var nameCtrl = TextEditingController(text: "ODC");


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                  "Creation de compte",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                gapH16,
                MTextField(
                    label: "Nom d'utilisateur",
                    hintText: "Saisir par ex: naruto...",
                    controller: nameCtrl),
                MTextField(
                    label: "Email",
                    hintText: "Saisir votre adresse mail...",
                    controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,),
                MTextField(
                    label: "Numero de telephone",
                    hintText: "saisir 08XXXXXX...",
                    controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                ),
                MTextField(
                    label: "Mot de passe",
                    obscureText: true,
                    hintText: "Saisir votre mot de passe...",
                    controller: passwordCtrl),
                MTextField(
                    label: "Confirmer Mot de passe",
                    obscureText: true,
                    hintText: "Confirmer votre mot de passe...",
                    controller: confirmPasswordCtrl),
                gapH24,
                MButton(
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                  text: "Créer Compte",
                 // isLoading: state.isLoading,
                  onClick: () {
                    //_onConnect(state);
                    Map<String, dynamic> userToCreate={
                      "id": Uuid().v1(),
                      "nom": nameCtrl.text,
                      "email": emailCtrl.text,
                      "phone": phoneCtrl.text,
                      "password": passwordCtrl.text
                    };
                    var provider= ref.read(userRepoProvider);
                    provider.creerUser(userToCreate);
                    context.replaceNamed(Urls.home.name);

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

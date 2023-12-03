import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';
import 'package:new_ecommerce_foundations/widgets/MButton.dart';
import 'package:new_ecommerce_foundations/widgets/MImage.dart';
import 'package:new_ecommerce_foundations/widgets/MTextField.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height*0.05),
                const MImage(url: "assets/gestion.png", isNetwork: false,height: 170,),
                Text(
                  "Authentification",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                gapH16,
                MTextField(label: "Email",hintText: "Saisir votre adresse mail...", controller: emailCtrl),
                MTextField(label: "Mot de passe",hintText: "Saisir votre mot de passe...", controller: passwordCtrl),
                gapH24,
                MButton(backgroundColor: Colors.orange,textColor: Colors.white,
                  text: "Se connecter",
                  onClick: () {},
                  mainAxisSize: MainAxisSize.max,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.p48, vertical: Sizes.p20),
                  child: Divider(),
                ),
                MButton(backgroundColor: Colors.transparent,textColor: Colors.black,elevation: 0,
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
}

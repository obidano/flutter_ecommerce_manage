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

import '../../data/categorie_repo.dart';

class CreerCategoryPage extends ConsumerStatefulWidget {
  const CreerCategoryPage({super.key});

  @override
  ConsumerState createState() => _CreerCategoryState();
}

class _CreerCategoryState extends ConsumerState<CreerCategoryPage> {
  var nameCtrl = TextEditingController(text: "");

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
                  "Creation Categorie",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                gapH16,
                MTextField(
                    label: "Nom categorie",
                    hintText: "Saisir par ex: naruto...",
                    controller: nameCtrl),
                gapH24,
                MButton(
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                  text: "Créer",
                 // isLoading: state.isLoading,
                  onClick: () async {
                    Map<String, dynamic> data={
                      "id": Uuid().v1(),
                      "nom": nameCtrl.text,
                    };
                    var provider= ref.read(categoriRepoProvider); // mettre categorie prodvider
                    await provider.creerCategory(data);
                    print("Enregistrement reussi");
                     context.pop();
                    //context.pushNamed(Urls.listeCategories.name);

                  },
                  mainAxisSize: MainAxisSize.max,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.p48, vertical: Sizes.p20),
                  child: Divider(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

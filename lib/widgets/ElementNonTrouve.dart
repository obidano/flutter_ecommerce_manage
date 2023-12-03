import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/widgets/MImage.dart';

import '../routers.dart';
import '../utils/constantes.dart';
import 'MButton.dart';

///  widget pour afficher  un message d'erreur quand il n'existe aucune
///  correspondance par rapport à une liste des données
class ElementNonTrouve extends StatelessWidget {
  final String message;
  final String? routeToGo;

  const ElementNonTrouve({super.key, required this.message, this.routeToGo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const MImage(
              url: "assets/404.png",
              isNetwork: false,
            ),
            gapH32,
            MButton(
                onClick: () {
                  context.goNamed(Urls.home.name);
                },
                text: "Quitter la page"
                )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            gapH32,
            MButton(
                onClick: () {
                  Navigator.of(context).popUntil((route) => routeToGo != null
                      ? route.settings.name == routeToGo
                      : route.isFirst);
                },
                text: "Retour à la page d'Accueil" //.hardcoded,
                )
          ],
        ),
      ),
    );
  }
}

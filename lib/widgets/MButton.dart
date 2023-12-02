

import 'package:flutter/material.dart';
import '../utils/constantes.dart';

// Bouton avec gestion d'un indicateur de chargement
class MButton extends StatelessWidget {
  const MButton(
      {super.key, required this.text, this.isLoading = false, this.onClick});
  final String text;
  final bool isLoading;
  final VoidCallback? onClick;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: ElevatedButton(
        onPressed: onClick,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../utils/constantes.dart';

// Bouton avec gestion d'un indicateur de chargement
class MButton extends StatelessWidget {
  const MButton(
      {super.key,
      required this.text,
      this.isLoading = false,
      this.onClick,
      this.elevation,
      this.backgroundColor,
      this.icon});

  final String text;
  final bool isLoading;
  final VoidCallback? onClick;
  final double? elevation;
  final Color? backgroundColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p32,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.white,
            elevation: elevation ?? 1.0),
        onPressed: onClick,
        child: isLoading
            ? const CircularProgressIndicator()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    const Icon(Icons.refresh),
                    gapW8,
                  ],
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.deepOrange),
                  ),
                ],
              ),
      ),
    );
  }
}

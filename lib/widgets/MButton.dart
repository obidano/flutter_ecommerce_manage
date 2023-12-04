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
      this.icon,
      this.mainAxisSize = MainAxisSize.min,
      this.textColor = Colors.deepOrange});

  final MainAxisSize mainAxisSize;
  final String text;
  final bool isLoading;
  final VoidCallback? onClick;
  final double? elevation;
  final Color? backgroundColor;
  final Color textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p64,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Ajustez la valeur du rayon selon vos besoins
          ),
        ).merge(ButtonStyle(elevation:
            MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return 0.0;
          return elevation ?? 1.0;
        }))),
        onPressed: onClick,
        child: Row(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              const CircularProgressIndicator(),
              gapW8,
            ],
            if (icon != null && !isLoading) ...[
              const Icon(Icons.refresh),
              gapW8,
            ],
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

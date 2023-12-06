import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/widgets/MImage.dart';

import '../routers.dart';
import '../utils/constantes.dart';
import 'MButton.dart';

///  widget pour afficher  un message d'erreur
///  quand la liste des données est vide
class EmptyList extends ConsumerStatefulWidget {
  final String? message;
  final String? routeToGo;
  final String? actionLabel;
  final Function()? onActionClicked;

  const EmptyList(
      {super.key,
      this.message,
      this.routeToGo,
      this.onActionClicked,
      this.actionLabel});

  @override
  ConsumerState<EmptyList> createState() => _EmptyListState();
}

class _EmptyListState extends ConsumerState<EmptyList> {
  List<String> imagesList = [
    "assets/empty_list/empty_list_1.webp",
    "assets/empty_list/empty_list_2.webp",
    "assets/empty_list/empty_list_3.webp",
    "assets/empty_list/empty_list_4.png",
    "assets/empty_list/empty_list_5.png",
  ];
  late String selectedImages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final random = Random();
    var i = random.nextInt(imagesList.length);
    selectedImages = imagesList[i];
  }

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
              widget.message ?? "La liste est vide",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            MImage(
              url: selectedImages,
              isNetwork: false,
              height: 150,
            ),
            gapH32,
            MButton(
                icon: Icons.refresh,
                elevation: 0,
                onClick: () {
                  if (widget.onActionClicked != null) widget.onActionClicked!();
                },
                text: widget.actionLabel ?? "Actualiser")
          ],
        ),
      ),
    );
  }
}

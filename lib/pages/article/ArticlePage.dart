import 'package:flutter/material.dart';
import 'package:new_ecommerce_foundations/data/fakeData.dart';
import 'package:collection/collection.dart';
import '../../widgets/ElementNonTrouve.dart';

class ArticlePage extends StatelessWidget {
  ArticlePage({super.key});

  String articleID = ""; // l'ID de l'article

  @override
  Widget build(BuildContext context) {
    var product =
        fakeArticlesList.firstWhereOrNull((e) => e["id"] == articleID);

    // on verifie si l'article cherché à travers l'ID, n'est pas null
    // pour decider quoi afficher
    return Scaffold(
        body: product == null
            ? const ElementNonTrouve(
                message: "Article non trouvé",
              )
            : contenuArticle(product));
  }

  Widget contenuArticle(Map product) {
    return CustomScrollView(
      slivers: [],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:new_ecommerce_foundations/widgets/MImage.dart';
import 'package:intl/intl.dart';
import '../../../../utils/constantes.dart';

class ArticleInfo extends StatelessWidget {
  final Map<String, dynamic> article;

  ArticleInfo({super.key, required this.article});

  final NumberFormat formatter = NumberFormat('#,##0.00');

  @override
  Widget build(BuildContext context) {
    var prixFormatte = formatter.format(article["prix"]);
    return Column(
      children: [
        Card(
          child: MImage(
            url: article["image"],
            width: 100,
          ),
        ),
        gapH8,
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(article['nom'],
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Text(prixFormatte,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                gapH8,
                Text(article['description'] ?? "",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodySmall),
                // Only show average if there is at least one rating
                gapH8,
                const Divider(),
                gapH8,

                const Divider(),
                gapH8,
              ],
            ),
          ),
        ),
      ],
    );
  }


}

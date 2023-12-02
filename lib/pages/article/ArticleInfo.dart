import 'package:flutter/material.dart';
import 'package:new_ecommerce_foundations/widgets/MImage.dart';

class ArticleInfo extends StatelessWidget {
  final Map<String, dynamic> article;

  const ArticleInfo({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: MImage(url: article["image"]),
        )
      ],
    );
  }
}

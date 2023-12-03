import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/features/article/data/fake_article_repo.dart';
import '../../../../widgets/ElementNonTrouve.dart';
import 'ArticleInfo.dart';

class ArticlePage extends StatelessWidget {
  final String articleID; // l'ID de l'article

  const ArticlePage({super.key, required this.articleID});

  @override
  Widget build(BuildContext context) {
    var article = FakeArticleRepo.instance.getArticleById(articleID);

    // on verifie si l'article cherché à travers l'ID, n'est pas null
    // pour decider quoi afficher
    return Scaffold(
        appBar: _appBar(context, article),
        body: article == null
            ? const ElementNonTrouve(
                message: "Article non trouvé",
              )
            : _contenuArticle(article));
  }

  Widget _contenuArticle(Map<String, dynamic> article) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [ArticleInfo(article: article)],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context, Map<String, dynamic>? article) {
    return AppBar(
      title: Text(article?['nom'] ?? ""),
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios)),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
    );
  }
}

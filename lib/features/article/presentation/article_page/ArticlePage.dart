import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/features/article/data/fake_article_repo.dart';
import '../../../../widgets/ElementNonTrouve.dart';
import 'ArticleInfo.dart';

class ArticlePage extends ConsumerWidget {
  final String articleID; // l'ID de l'article

  ArticlePage({super.key, required this.articleID});

  Map<String, dynamic>? article = null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var articleProvider = ref.watch(articleRepoProvider);
    var articleProviderValue = ref.watch(streamOneArticleProvider(articleID));

    return Scaffold(
        appBar: _appBar(context),
        body: articleProviderValue.when(
          skipLoadingOnRefresh: false,
            data: (data) {
              article = data;
              return _contenuPrincipal();
            },
            error: (err, st) => const ElementNonTrouve(
                  message: "Article non trouvé",
                ),
            loading: () => const Center(child: CircularProgressIndicator())));
  }

  Widget _contenuPrincipal() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [ArticleInfo(article: article!)],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
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

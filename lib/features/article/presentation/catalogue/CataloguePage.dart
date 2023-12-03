import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/features/article/data/fake_article_repo.dart';
import 'package:new_ecommerce_foundations/features/article/presentation/catalogue/ArticleListVue.dart';
import 'package:new_ecommerce_foundations/routers.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';
import 'package:new_ecommerce_foundations/widgets/DashboardItem.dart';
import 'package:new_ecommerce_foundations/widgets/EmptyList.dart';

import 'MenuNavigation.dart';

class CataloguePage extends ConsumerWidget {
  List<Map<String, dynamic>> _articles = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _catalogueAppBar(),
      drawer: const MenuNavigation(),
      body: Column(
        children: [
          _tableauBordCatalogue(context),
          Expanded(child: _contenuPrincipal(context, ref)),
        ],
      ),
    );
  }

  Widget _tableauBordCatalogue(BuildContext context) {
    return Container(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
          children: const [
            DashboardItem(
                icon: Icons.show_chart, label: "Stats 1", value: "0.0000"),
            gapW8,
            DashboardItem(
                icon: Icons.show_chart, label: "Stats 2", value: "0.0000"),
            gapW8,
            DashboardItem(
                icon: Icons.show_chart, label: "Stats 3", value: "0.0000"),
            gapW8
          ],
        ));
  }

  Widget _contenuPrincipal(BuildContext context, WidgetRef ref) {
    var provider=ref.watch(articleRepoProvider);
    var articleProviderValue = ref.watch(futureArticlesListProvider);

    return articleProviderValue.when(
        skipLoadingOnRefresh: false,
        data: (data) {
          _articles = data;
          if (_articles.isEmpty) {
            return EmptyList(onActionClicked: () {
               provider.updateArticles();
              ref.refresh(futureArticlesListProvider);
            });
          }
          return ArticleListVue(articles: _articles);
        },
        error: (err, st) => const Center(child: EmptyList()),
        loading: () => const Center(child: CircularProgressIndicator()));
  }

  AppBar _catalogueAppBar() {
    return AppBar(
      title: Text("Catalogues (${_articles.length})"),
      centerTitle: true,
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
    );
  }
}

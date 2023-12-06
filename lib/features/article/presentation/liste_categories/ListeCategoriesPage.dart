import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/features/article/data/fake_article_repo.dart';
import 'package:new_ecommerce_foundations/features/article/presentation/catalogue/ArticleListVue.dart';
import 'package:new_ecommerce_foundations/features/article/presentation/liste_categories/CategoriesListVue.dart';
import 'package:new_ecommerce_foundations/routers.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';
import 'package:new_ecommerce_foundations/widgets/DashboardItem.dart';
import 'package:new_ecommerce_foundations/widgets/EmptyList.dart';

import '../../data/categorie_repo.dart';
import '../../domain/Categorie.dart';


class ListeCategoriesPage extends ConsumerWidget {
  List<Categorie> _categories = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _catalogueAppBar(ref, context),
      body: Column(
        children: [
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
    var categoriesProviderValue = ref.watch(categoriesDataProvider);

    return categoriesProviderValue.when(
        skipLoadingOnRefresh: false,
        data: (data) {
          _categories = data;
          if (_categories.isEmpty) {
            return EmptyList(onActionClicked: () {
               provider.updateArticles();
              ref.refresh(futureArticlesListProvider);
            });
          }
          return CategoriesListVue(categories: _categories);
        },
        error: (err, st) {
          print("Error: $err" );
          return const Center(child: Text("Failed"));
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }

  AppBar _catalogueAppBar(WidgetRef ref, BuildContext context) {
    return AppBar(
      title: _titrePage(ref),
      centerTitle: true,
      actions: [IconButton(onPressed: () async{
        var res= await context.pushNamed(Urls.creerCategorie.name);
        print("Retour de la page creation");
        ref.refresh(categoriesDataProvider);
        // ref.invalidate(categoriesDataProvider);

      }, icon: const Icon(Icons.add))],
    );
  }

  _titrePage(WidgetRef ref) {
    var categoriesProviderValue = ref.watch(categoriesDataProvider);
    return categoriesProviderValue.when(
      data: (data)=>Text("Categories (${data.length})"),
      error: (err,_) => Text("Categories"),
      loading: ()=>Text("Categories...")
    );

  }

}

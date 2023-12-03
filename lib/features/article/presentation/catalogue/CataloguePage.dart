import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/data/fakeData.dart';
import 'package:new_ecommerce_foundations/features/article/data/fake_article_repo.dart';
import 'package:new_ecommerce_foundations/routers.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';
import 'package:new_ecommerce_foundations/widgets/DashboardItem.dart';
import 'package:new_ecommerce_foundations/widgets/MImage.dart';

class CataloguePage extends ConsumerWidget {
  List<Map<String, dynamic>> articles = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var articleProvider=ref.watch(articleRepoProvider);
    articles=articleProvider.getArticles();
    return Scaffold(
      appBar: _catalogueAppBar(),
      drawer: _menuNavigation(context),
      body: Column(
        children: [
          _tableauBordCatalogue(context),
          Expanded(child: _contenuPage(context, )),
        ],
      ),
    );
  }

  Widget _tableauBordCatalogue(BuildContext context) {
    return Container(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
          children: const [
            DashboardItem(
                icon: Icons.show_chart, label: "Stats 1", value: "0.0000"),
            gapW8,
            DashboardItem(
                icon: Icons.show_chart, label: "Stats 1", value: "0.0000"),
            gapW8
          ],
        ));
  }

  Widget _contenuPage(
      BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: articles.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(Sizes.p16),
      itemBuilder: (_, i) {
        Map article = articles[i];
        int commandes = 12;
        return ListTile(
          onTap: () {
            context.goNamed(Urls.detailArticle.name,
                pathParameters: {"id": article['id']});
          },
          leading: MImage(
            url: article['image'],
          ),
          title: Row(
            children: [
              Flexible(
                  child: Text(
                article['nom'],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
              gapW12,
              Text(" CDF ${article['prix']}",
                  style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
          subtitle: Row(
            children: [
              const Text("Commande en cours:"),
              gapW12,
              Text("$commandes",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold))
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(.2),
          ),
        );
      },
    );
  }

  AppBar _catalogueAppBar() {
    return AppBar(
      title: Text("Catalogues (${articles.length})"),
      centerTitle: true,
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
    );
  }

  Drawer _menuNavigation(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.5),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.p12),
              child: Text(
                'E-GESTION',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.p24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.category_rounded,
            ),
            title: const Text('Categories'),
            onTap: () {
              context.goNamed(Urls.login.name);
            },
          ),
          Divider(thickness: 2, color: Colors.grey.withOpacity(.1)),
          ListTile(
            leading: const Icon(
              Icons.people,
            ),
            title: const Text('Clients'),
            onTap: () {},
          ),
          Divider(thickness: 2, color: Colors.grey.withOpacity(.1)),
          ListTile(
            leading: const Icon(
              Icons.shopping_cart,
            ),
            title: const Text('Commandes'),
            onTap: () {},
          ),
          Divider(thickness: 2, color: Colors.grey.withOpacity(.1)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/routers.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';
import 'package:new_ecommerce_foundations/widgets/MImage.dart';

class ArticleListVue extends StatelessWidget {
  const ArticleListVue({super.key, required this.articles});
  final List<Map<String, dynamic>> articles;

  @override
  Widget build(BuildContext context) {
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
}

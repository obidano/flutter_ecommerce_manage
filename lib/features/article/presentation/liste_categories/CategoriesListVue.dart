import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/features/article/domain/Categorie.dart';
import 'package:new_ecommerce_foundations/routers.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';
import 'package:new_ecommerce_foundations/widgets/MImage.dart';

class CategoriesListVue extends StatelessWidget {
  const CategoriesListVue({super.key, required this.categories});
  final List<Categorie> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: categories.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(Sizes.p16),
      itemBuilder: (_, i) {
        Categorie category = categories[i];
        int commandes = 12;
        return ListTile(
          onTap: () {
          },
          leading: Icon(Icons.category),
          title: Row(
            children: [
              Flexible(
                  child: Text(
                    category.nom ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )),
              gapW12,
              Text("",
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

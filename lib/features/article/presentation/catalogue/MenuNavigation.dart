import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/routers.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';

class MenuNavigation extends StatelessWidget {
  const MenuNavigation({super.key});

  @override
  Widget build(BuildContext context) {
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/features/authenttication/presentation/login/LoginController.dart';
import 'package:new_ecommerce_foundations/routers.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';
import 'package:new_ecommerce_foundations/utils/errorDialog.dart';

import '../../../authenttication/data/abstract_auth_repo.dart';

class MenuNavigation extends ConsumerWidget {
  const MenuNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(loginControllerProvider, (previous, next) {
      if (next.hasError) {
        showErrorDialog(context, next.error.toString());
      }
    });
    var state = ref.watch(loginControllerProvider);
    var asyncConnectedUser = ref.watch(connectedProvider);

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'E-GESTION',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.p24,
                        fontWeight: FontWeight.bold),
                  ),
                  _userEmail(asyncConnectedUser),
                ],
              ),
            ),
          ),
          _menuItem(context,
              title: 'Categories',
              icon: Icons.category_rounded,
              route: Urls.login.name),
          _menuItem(context, title: 'Clients', icon: Icons.people, route: null),
          _menuItem(context,
              title: 'Commandes', icon: Icons.shopping_cart, route: null),
          state.isLoading
              ? const SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(child: CircularProgressIndicator()))
              : _buttonDeconnexion(context, ref)
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context,
      {required String title, required IconData icon, String? route}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
          ),
          title: Text(title),
          onTap: () {
            if (route != null) {
              context.goNamed(route);
            }
          },
        ),
        Divider(thickness: 2, color: Colors.grey.withOpacity(.1)),
      ],
    );
  }

  Widget _buttonDeconnexion(BuildContext context, WidgetRef ref) {
    return Column(children: [
      ListTile(
        leading: const Icon(
          Icons.exit_to_app,
        ),
        title: const Text('Deconnexion'),
        onTap: () async {
          final res =
              await ref.read(loginControllerProvider.notifier).deconnexion();
          if (res && context.mounted) {
            context.pushReplacementNamed(Urls.login.name);
          }
        },
      ),
      Divider(thickness: 2, color: Colors.grey.withOpacity(.1)),
    ]);
  }

  _userEmail(AsyncValue<Map<String, dynamic>?> asyncConnectedUser) {
    return asyncConnectedUser.when(data: (Map<String, dynamic>? data) {
      return Text(
        "${data?['email']}",
        style: const TextStyle(
            color: Colors.grey,
            fontSize: Sizes.p16,
            fontWeight: FontWeight.bold),
      );
    }, error: (err, st) {
      return const Text("Erreur");
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}

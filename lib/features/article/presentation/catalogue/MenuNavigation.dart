import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/features/authenttication/presentation/login/LoginController.dart';
import 'package:new_ecommerce_foundations/routers.dart';
import 'package:new_ecommerce_foundations/utils/constantes.dart';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E-GESTION',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.p24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'user email',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: Sizes.p16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
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
          Divider(thickness: 3, color: Colors.grey.withOpacity(.1)),
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

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

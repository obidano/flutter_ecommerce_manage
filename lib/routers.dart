import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:new_ecommerce_foundations/features/authenttication/data/fake_auth_repo.dart';
import 'package:new_ecommerce_foundations/features/authenttication/presentation/login/LoginPage.dart';

import 'features/article/presentation/article_page/ArticlePage.dart';
import 'features/article/presentation/catalogue/CataloguePage.dart';

enum Urls { home, detailArticle, login }

final routerProvider = Provider<GoRouter>((ref) {
  final authRpovider = ref.watch(authRepoProvider);
  return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: "/home",
      redirect: (context, state) {
        bool connected = authRpovider.connectedUser != null;
        debugPrint("connected $connected / state.matchedLocation ${state.matchedLocation}");

        if (!connected && state.matchedLocation.startsWith("/home")) {
          return "/login";
        }

        if (connected && state.matchedLocation == "/login") {
          return "/home";
        }

        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: "/home",
          name: Urls.home.name,
          builder: (BuildContext context, GoRouterState state) =>
              CataloguePage(),
          routes: <RouteBase>[
            GoRoute(
              path: "details/:id",
              name: Urls.detailArticle.name,
              pageBuilder: (BuildContext context, GoRouterState state) {
                final articleId = state.pathParameters["id"];
                return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: ArticlePage(articleID: articleId ?? ""));
              },
            ),
          ],
        ),
        GoRoute(
          path: "/login",
          name: Urls.login.name,
          builder: (BuildContext context, GoRouterState state) =>
              const LoginPage(),
        ),
      ],
      errorBuilder: (context, state) => CataloguePage());
});
//final GoRouter routerConfig = ;

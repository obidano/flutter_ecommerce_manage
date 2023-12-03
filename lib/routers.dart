import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/article/presentation/article_page/ArticlePage.dart';
import 'features/article/presentation/catalogue/CataloguePage.dart';

enum Urls { home, detailArticle, login }

final GoRouter routerConfig = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: <RouteBase>[
      GoRoute(
        path: "/",
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
             CataloguePage(),
      ),
    ],
    errorBuilder: (context, state) =>  CataloguePage());

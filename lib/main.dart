import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_ecommerce_foundations/features/article/data/categorie_repo.dart';
import 'package:new_ecommerce_foundations/features/article/domain/Categorie.dart';
import 'package:new_ecommerce_foundations/features/authenttication/data/fake_auth_repo.dart';
import 'package:new_ecommerce_foundations/utils/localDatabase.dart';
import 'features/authenttication/data/abstract_auth_repo.dart';
import 'features/authenttication/data/user_repo.dart';
import 'routers.dart';

void main() async {
  // point de depart de l'application
  WidgetsFlutterBinding.ensureInitialized();
  var db = await LocalDatabase.createDatabase("app.db");
  final userRepo= UserRepo(db);
  final categoryRepo= CategorieRepo(db);
  final authRepo = await FakeAuthRepo.createAuthRepo();
  runApp(ProviderScope(
      overrides: [
        authRepoProvider.overrideWithValue(authRepo),
        userRepoProvider.overrideWithValue(userRepo),
        categoriRepoProvider.overrideWithValue(categoryRepo),
      ],
      child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      //home: const CataloguePage(),
    );
  }
}

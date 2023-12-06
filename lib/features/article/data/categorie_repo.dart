
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';

import '../domain/Categorie.dart';

class CategorieRepo{
  // configuration database
  Database db;
  var store=StoreRef.main();
  List<Categorie> listCategories=[];

  CategorieRepo(this.db);

  Future<void> setLocalCategorie(List data) async{
    await store.record('categorie_key').put(db, data);
  }

  Future getLocalCategories() async{
    var donneesBrute= await store.record("categorie_key").get(db);
    return donneesBrute ?? [];
  }

  creerCategory(Map<String, dynamic> categorie) async{
    var categoriesExistantes= await getLocalCategories();
    List conversion=categoriesExistantes.map((e)=>e).toList();
    conversion.add(categorie);
   await setLocalCategorie(conversion);
  }

  modifierCategory(String id, Map<String, dynamic> categorie) async{
    var categoriesExistantes= await getLocalCategories();
    int index= categoriesExistantes.indexWhere((c)=> c["id"]==id);
    if(index!= -1){
      categoriesExistantes[index]=categorie;
    }
    await setLocalCategorie(categoriesExistantes);
  }

  Future<List<Categorie>> afficherCategories() async{
    var categoriesExistantes= await getLocalCategories();
    List<Categorie> categories= categoriesExistantes
        .map<Categorie>((c)=>Categorie.fromMap(c)).toList();
    await Future.delayed(Duration(seconds:2));
    return categories;
  }



}

final categoriRepoProvider = Provider<CategorieRepo>((ref) {
  throw UnimplementedError();
});

final categoriesDataProvider = FutureProvider<List<Categorie>>((ref) async {
  print("Refresh npage");
  var provider=ref.watch(categoriRepoProvider);
  return provider.afficherCategories();
});
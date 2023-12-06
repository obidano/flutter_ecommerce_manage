
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';

import '../domain/Categorie.dart';

class CategorieRepo{
  // configuration database
  Database db;
  var store=StoreRef.main();
  List<Categorie> listCategories=[];

  CategorieRepo(this.db);

  Future<void> setLocalCategorie(List<Map<String, dynamic>> data) async{
    await store.record('categorie_key').put(db, data);
  }

  Future<List<Map<String, dynamic>>> getLocalCategories() async{
    var donneesBrute= await store.record("categorie_key").get(db) as List<Map<String, dynamic>>?;
    return donneesBrute ?? [];
  }

  creerCategory(Map<String, dynamic> categorie) async{
    var categoriesExistantes= await getLocalCategories();
    categoriesExistantes.add(categorie);
    setLocalCategorie(categoriesExistantes);
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
        .map((c)=>Categorie.fromMap(c)).toList();
    return categories;
  }



}

final categoriRepoProvider = Provider<CategorieRepo>((ref) {
  throw UnimplementedError();
});

final categoriesProvider = FutureProvider<List<Categorie>>((ref) async {
  var provider=ref.watch(categoriRepoProvider);
  return provider.afficherCategories();
});
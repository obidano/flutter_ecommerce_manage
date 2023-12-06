

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';

import '../domain/User.dart';

class UserRepo{
  User? user;
  Database db;
  var store=StoreRef.main();
  
  UserRepo(this.db);

  Future<Map<String, dynamic>?> getLocalUser() async{
    var userBrute= await store.record("user_key").get(db);
    var userMap= userBrute as Map<String, dynamic>?;
    return userMap;
  }

  Future<void> setLocalUser(Map<String, dynamic>? data) async{
    await store.record('user_key').put(db, data);
  }
  
  Future<void> creerUser(Map<String, dynamic> data) async{
    await setLocalUser(data);
    user= User.fromMap(data);
  }
  
  void modifierUser(Map<String, dynamic> data) async{
    await setLocalUser(data);
    user= User.fromMap(data);
  }
  
  void seConnecter(String email, String password) async{
      Map<String, dynamic>? userMap=  await getLocalUser();
      if(userMap!=null){
        bool check=userMap['email']==email && userMap['password']==password;
        if(check){
         user= User.fromMap(userMap);
        }
      }
  }
  
   void seDeconnecter() async{
    user=null;
    await setLocalUser(null);
   }

   Future<bool> controleUtilisateurExistant() async{
    var userMap=await getLocalUser() ;
    return userMap!=null;
   }

}

final userRepoProvider = Provider<UserRepo>((ref) {
  throw UnimplementedError();
});
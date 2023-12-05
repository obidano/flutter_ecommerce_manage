

import 'package:sembast/sembast.dart';

import '../domain/User.dart';

class UserRepo{
  User? user;
  Database db;
  var store=StoreRef.main();
  
  UserRepo(this.db);
  
  void creerUser(Map<String, dynamic> data) async{
    await store.record("user_key").put(db, data);
    user= User.fromMap(data);
  }
  
  void modifierUser(Map<String, dynamic> data) async{
    await store.record("user_key").put(db, data);
    user= User.fromMap(data);
  }
  
  void seConnecter(String email, String password) async{
    var donneeBrute= await store.record("user_key").get(db);
      Map<String, dynamic>? userMap=  donneeBrute as Map<String, dynamic>?;
      if(userMap!=null){
        bool check=userMap['email']==email && userMap['password']==password;
        if(check){
          // TODO: completer l'authentification
          // donner une valeur à user
        }
      }
  }
  
   void seDeconnecter(){
    user=null;

   }
  
  
}
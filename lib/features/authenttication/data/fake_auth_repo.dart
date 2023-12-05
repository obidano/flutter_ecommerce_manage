import 'package:new_ecommerce_foundations/utils/localDatabase.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import 'abstract_auth_repo.dart';

class FakeAuthRepo implements AuthRepo {
  Map<String, dynamic>? connectedUser;
  final Database db;
  final store = StoreRef.main();
  static const userKey = "USER_KEY";

  FakeAuthRepo({required this.db});

  Future<Map<String, dynamic>?> getLocalConnectedUser() async {
    var dataLocal = await store.record(userKey).get(db);
    connectedUser = dataLocal as Map<String, dynamic>?;
    return connectedUser;
  }

  Stream<Map<String, dynamic>?> watchConnectedUser() {
    final record = store.record(userKey);
    return record.onSnapshot(db).map((event) {
      return event as Map<String, dynamic>?;
    });
  }

  Future<void> setLocalConnectedUser(Map<String, dynamic>? data) async {
    connectedUser=data;
    store.record(userKey).put(db, data);
  }

  static Future<FakeAuthRepo> createAuthRepo() async {
    return FakeAuthRepo(db: await LocalDatabase.createDatabase('app.db'));
  }

  @override
  Future<void> authenticate(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception("Authentication failed");
    setLocalConnectedUser({"id": const Uuid().v4(), "email": email});
  }

  @override
  Future<void> createAccount(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    setLocalConnectedUser({"id": const Uuid().v4(), "email": email});
  }

  @override
  Future<void> deconnecter() async {
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception("Erreur reseau");
    // _authState.value = null;
    setLocalConnectedUser(null);
  }
}

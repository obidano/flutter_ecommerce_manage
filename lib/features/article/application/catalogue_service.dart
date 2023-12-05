
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogueService{
  final Ref ref;

  CatalogueService(this.ref);

  void calculer(){

  }
  
}

final catalogueSerivceProvider = Provider<CatalogueService>((ref) {
  return  CatalogueService(ref);
});
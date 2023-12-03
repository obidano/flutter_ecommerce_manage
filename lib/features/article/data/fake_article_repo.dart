import 'package:new_ecommerce_foundations/data/fakeData.dart';
import "package:collection/collection.dart";

class FakeArticleRepo {
  FakeArticleRepo._();

  static FakeArticleRepo instance = FakeArticleRepo._();

  final List<Map<String, dynamic>> _articles = fakeArticlesList;

  List<Map<String, dynamic>> getArticles() {
    return _articles;
  }

  Future<List<Map<String, dynamic>>> fetchArticles() {
    return Future.value(_articles);
  }

  Stream<List<Map<String, dynamic>>> watchArticles() {
    return Stream.value(_articles);
  }

  Map<String, dynamic>? getArticleById(String id) {
    return _articles.firstWhereOrNull((e) => e["id"] == id);
  }

  Stream<Map<String, dynamic>?> watchOneArticle(String id) {
    return watchArticles().map(
        (articlesData) => articlesData.firstWhereOrNull((e) => e["id"] == id));
  }
}

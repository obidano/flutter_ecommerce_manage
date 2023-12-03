import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_ecommerce_foundations/data/fakeData.dart';
import "package:collection/collection.dart";

class FakeArticleRepo {
   List<Map<String, dynamic>> _articles = [];// fakeArticlesList;

  List<Map<String, dynamic>> getArticles() {
    return [];
    return _articles;
  }

  updateArticles(){
    _articles=fakeArticlesList;
  }

  Future<List<Map<String, dynamic>>> fetchArticles() async {
    await Future.delayed(const Duration(seconds: 2));
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

final articleRepoProvider = Provider<FakeArticleRepo>((ref) {
  return FakeArticleRepo();
});

final futureArticlesListProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
      //caching
    final link=  ref.keepAlive();
    Timer(const Duration(seconds: 15),(){
      link.close();
    });
  final repo = ref.watch(articleRepoProvider);
  return repo.fetchArticles();
});

final streamOneArticleProvider =
StreamProvider.autoDispose.family<Map<String, dynamic>?, String>((ref, id) {
  final repo = ref.watch(articleRepoProvider);
  return repo.watchOneArticle(id);
});

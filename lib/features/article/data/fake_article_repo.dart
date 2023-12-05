import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_ecommerce_foundations/data/fakeData.dart';
import "package:collection/collection.dart";
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "fake_article_repo.g.dart";

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

@Riverpod(keepAlive: false)
FakeArticleRepo articleRepo (ArticleRepoRef ref) {
  return FakeArticleRepo();
}

@Riverpod(keepAlive: false)
Future<List<Map<String, dynamic>>> futureArticlesList(FutureArticlesListRef ref){
  final repo = ref.watch(articleRepoProvider);
  return repo.fetchArticles();
}

final streamOneArticleProvider =
StreamProvider.autoDispose.family<Map<String, dynamic>?, String>((ref, id) {
  final repo = ref.watch(articleRepoProvider);
  return repo.watchOneArticle(id);
});

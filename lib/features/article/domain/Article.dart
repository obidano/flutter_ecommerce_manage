typedef ArticleID = String;

class Article {
  ArticleID? id;
  String? nom;
  double? prix;
  String? description;
  String? image;

  Article({
    this.id,
    this.nom,
    this.prix,
    this.description,
    this.image,
  });

}

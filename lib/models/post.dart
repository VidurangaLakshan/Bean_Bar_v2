// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  List<Article> articles;

  Post({
    required this.articles,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  int id;
  int userId;
  String? image;
  String title;
  String slug;
  String body;
  dynamic readingTime;
  DateTime? publishedAt;
  int featured;
  int approved;
  dynamic reasonForRejection;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String? customCategories;

  Article({
    required this.id,
    required this.userId,
    required this.image,
    required this.title,
    required this.slug,
    required this.body,
    required this.readingTime,
    required this.publishedAt,
    required this.featured,
    required this.approved,
    required this.reasonForRejection,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.customCategories,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    userId: json["user_id"],
    image: json["image"],
    title: json["title"],
    slug: json["slug"],
    body: json["body"],
    readingTime: json["reading_time"],
    publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
    featured: json["featured"],
    approved: json["approved"],
    reasonForRejection: json["reason_for_rejection"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    customCategories: json["custom_categories"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "image": image,
    "title": title,
    "slug": slug,
    "body": body,
    "reading_time": readingTime,
    "published_at": publishedAt?.toIso8601String(),
    "featured": featured,
    "approved": approved,
    "reason_for_rejection": reasonForRejection,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "custom_categories": customCategories,
  };
}

import 'dart:convert';

import 'package:flutter_app_1/model/acticle.dart';
import 'package:flutter_app_1/secret/key.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> articles = List<Article>();

  Future<void> getNewsHeadlines(String country) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=$country&apiKey=$newsApiKey";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["description"] != null && element["urlToImage"] != null) {
          Article article = Article();

          article.title = element["title"];
          article.description = element["description"];
          article.url = element["url"];
          article.urlToImage = element["urlToImage"];
          articles.add(article);
        }
      });
    }
  }

  Future<void> getNewsByCategory(String country, String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$newsApiKey";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["description"] != null && element["urlToImage"] != null) {
          Article article = Article();

          article.title = element["title"];
          article.description = element["description"];
          article.url = element["url"];
          article.urlToImage = element["urlToImage"];
          articles.add(article);
        }
      });
    }
  }
}

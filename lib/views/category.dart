import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_1/helper/news.dart';
import 'package:flutter_app_1/model/acticle.dart';

import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_1/secret/key.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  final String country;

  CategoryScreen(this.category, this.country);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Article> articles = List<Article>();
  News news = News();

  getAndSetNews() async {
    await news.getNewsByCategory("in", widget.category);
    setState(() {
      articles = news.articles;
    });
  }

  @override
  void initState() {
    getAndSetNews();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category} News"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: articles.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return NewsTile(
              title: articles[index].title,
              description: articles[index].description,
              imgURL: articles[index].urlToImage,
              url: articles[index].url,
            );
          },
        ),
      ),
    );
  }
}

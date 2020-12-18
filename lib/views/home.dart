import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/helper/data.dart';
import 'package:flutter_app_1/helper/news.dart';
import 'package:flutter_app_1/model/acticle.dart';
import 'package:flutter_app_1/model/category.dart';
import 'package:flutter_app_1/views/articleView.dart';
import 'package:flutter_app_1/views/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final String country = "in";

class _HomeState extends State<Home> {
  List<Category> categories = List<Category>();
  List<Article> articles = List<Article>();
  News news = News();

  getAndSetNews() async {
    await news.getNewsHeadlines(country);
    setState(() {
      articles = news.articles;
    });
  }

  @override
  void initState() {
    getAndSetNews();
    categories = getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(700.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text("NewsApp"),
              elevation: 0,
            ),
            Container(
              height: 80.0,
              color: Colors.white.withOpacity(0.4),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    categories[index].imgURL,
                    categories[index].label,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ListView.builder(
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
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imgURL, label;

  CategoryTile(this.imgURL, this.label);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(label, country)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CachedNetworkImage(
                imageUrl: imgURL,
                height: 60.0,
                width: 120.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              height: 60.0,
              width: 120.0,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imgURL, title, description, url;
  NewsTile({this.title, this.description, this.imgURL, this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ArticleView(url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imgURL,
                height: 180.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(title),
            SizedBox(
              height: 8.0,
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}

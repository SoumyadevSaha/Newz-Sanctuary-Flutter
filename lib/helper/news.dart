import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async{

    String url = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=be0ff386d572459ea920355156f29192";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if(jsonData["status"] == "ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articleModel);
        }

      });
    }
  }

  Future<void> getQueryNews(final String query) async {
    String url = "https://newsapi.org/v2/everything?q=$query&apiKey=be0ff386d572459ea920355156f29192";
    news = [];

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if(jsonData["status"] == "ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articleModel);
        }

      });
    }
  }
}

class CategoryNews {
  List<ArticleModel> categoryNews = [];
  final String category;
  CategoryNews({required this.category});

  Future<void> getCategoryNews() async{

    String categoryUrl = "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=be0ff386d572459ea920355156f29192";
    var response = await http.get(Uri.parse(categoryUrl));

    var jsonData = jsonDecode(response.body);
    if(jsonData["status"] == "ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          categoryNews.add(articleModel);
        }

      });
    }
  }
}


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:s_newz/helper/news.dart';

import '../models/article_model.dart';
import 'article_view.dart';

class CategoryNewsView extends StatefulWidget {
  final String category;
  const CategoryNewsView({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryNewsView> createState() => _CategoryNewsViewState(category);
}

class _CategoryNewsViewState extends State<CategoryNewsView> {

  final String _category;

  bool isLoading = true;
  List<ArticleModel> articles = List <ArticleModel>.empty(growable: true);

  _CategoryNewsViewState(this._category);

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  void getCategoryNews() async
  {
    CategoryNews newsClass = CategoryNews(category: _category);
    await newsClass.getCategoryNews();
    articles = newsClass.categoryNews;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => {
            // Display a Toast at the center of the screen
              Fluttertoast.showToast(
                                    msg: "Developer : Soumyadev Saha",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black54,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                )
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Newz"),
                Text(" Sanctuary", style: TextStyle(color: Colors.blue)),
              ]),
        ),
        elevation: 0.0,
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.save)),
          )
        ],
      ),

      body : isLoading ? Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ) : Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index){
                    return BlogTile(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      description: articles[index].description,
                      url: articles[index].url,
                    );
                  },
                ),
              ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;
  const BlogTile({Key? key, required this.imageUrl, required this.title, required this.description, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
          blogUrl: url,
        )));
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imageUrl)
            ),
            const SizedBox(height: 7),
            Text(title, style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 7),
            Text(description, style: const TextStyle(color: Colors.white70),),
          ],
        ),
      ),
    );
  }
}
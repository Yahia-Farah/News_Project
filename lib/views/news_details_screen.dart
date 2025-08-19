import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/articles_response_model.dart';

class NewsDetails extends StatelessWidget {
  final ArticlesResponseModel article;
  const NewsDetails({super.key,required this.article});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                GestureDetector(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: (){
                    Navigator.pop(context);
                  },

                ),
                SizedBox(height: 24,),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ?? "",
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/images/no_image_available.jpg",fit: BoxFit.fill,),
                    width: double.infinity,
                    height: 270.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16,),
                Text(article.title ?? "",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,

                  ),),
                SizedBox(height: 6.0,),
                Text(article.author ?? "" ,
                  style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,

                ),),
                SizedBox(height: 6.0,),
                Text( "${article.publishedAt!.year}-${article.publishedAt!.month}-${article.publishedAt!.day}", style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,

                ),),
                SizedBox(height: 6.0,),

                Text(
                  article.content ?? "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

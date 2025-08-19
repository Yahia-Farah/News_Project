import 'package:arab_contractors/models/articles_response_model.dart';
import 'package:arab_contractors/views/news_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final textColor = Colors.white;
  final ArticlesResponseModel article;
  final double height ;
  const NewsCard({super.key, required this.article,this.height=150});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetails(article: article,)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/no_image_available.jpg",fit: BoxFit.fill,),
                width: double.infinity,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            Spacer(),
            Text(article.title ?? "",
              maxLines: 1 ,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 3.0,),
            Text( "${article.publishedAt?.year??""}-${article.publishedAt?.month ?? ""}-${article.publishedAt?.day??""}", style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:arab_contractors/view_model/saved_news_cubit/saved_news_cubit.dart';
import 'package:arab_contractors/views/widgets/news_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedNews extends StatelessWidget {
  const SavedNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved News"),
        centerTitle: true,
      ),
      body:BlocProvider(create: (context) => SavedNewsCubit()..getSavedNews(),
      child: BlocBuilder<SavedNewsCubit,SavedNewsState>(builder:
              (context, state)
                {
                  if(state is FailureState){
                    return Center(child: Text("no data"),);
                  }
                  else if(state is SuccessQueryState){
                    return SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: CarouselSlider.builder(
                                itemCount: 5,
                                itemBuilder:(context, index, realIndex)
                                {
                                  return NewsCard(article:context.read<SavedNewsCubit>().articles[index] ,height: 200,);
                                },
                                options: CarouselOptions(autoPlay: true,viewportFraction: 0.90,height: 300),
                              ),
                            ),
                            SliverGrid(delegate:SliverChildBuilderDelegate((context, index)
                            {
                              return NewsCard(article: context.read<SavedNewsCubit>().articles[index],);
                            },), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , childAspectRatio: 9/12, crossAxisSpacing: 4,mainAxisSpacing: 4 ),),
                          ],
                        ),
                      ),
                    )
                    ;}
                  else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
          )
      ));

  }
}

import 'package:arab_contractors/view_model/news_cubit/news_cubit.dart';
import 'package:arab_contractors/views/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "News",
          style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is FailureState) {
            return Center(child: Text(state.errorMessage));
          } else if (state is SuccessState || state is SuccessSearchState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: CarouselSlider.builder(
                      itemCount: 5,
                      itemBuilder: (context, index, realIndex) {
                        return NewsCard(
                          article: context.read<NewsCubit>().articles[index],
                          height: 200,
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 0.90,
                        height: 300,
                      ),
                    ),
                  ),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return NewsCard(
                        article: context.read<NewsCubit>().articles[index],
                      );
                    },
                    childCount: context.read<NewsCubit>().articles.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 9 / 12,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

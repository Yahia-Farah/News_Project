import 'package:arab_contractors/views/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/news_cubit/news_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (value){
                  context.read<NewsCubit>().searchNews(value);
                },
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if(state is FailureState){
                    return Center(child: Text(state.errorMessage),);
                  }
                  else if(state is SuccessSearchState){
                    return Column(
                      children: [
                        Expanded(
                          child: GridView.builder(itemCount: state.filteredArticles.length,
                              itemBuilder: (context, index){
                            return NewsCard(article: state.filteredArticles[index],);
                          }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , childAspectRatio: 9/12, crossAxisSpacing: 4,mainAxisSpacing: 4 ),
                        ),
                        )],
                    );
                  }
                  else if(state is SuccessState){
                    return Center(child: Text("No articles found"),);
                  }
                  else {
                    return Center(child: CircularProgressIndicator());
                    }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

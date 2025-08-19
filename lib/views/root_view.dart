import 'package:arab_contractors/views/news_screen.dart';
import 'package:arab_contractors/views/search_screen.dart';
import 'package:flutter/material.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _selectedIndex==0 ? NewsScreen() : SearchScreen() ,
      bottomNavigationBar: NavigationBar(
        overlayColor: WidgetStateProperty.all(Colors.white),
        indicatorColor: Colors.white,
        destinations: 
        [
        NavigationDestination(icon: Icon(Icons.home), label: "Home",selectedIcon: Icon(Icons.home,size: 40,),),
        NavigationDestination(icon: Icon(Icons.search), label: "Search" ,selectedIcon: Icon(Icons.search,size: 40,)),
      ],
      backgroundColor: Colors.white,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (selectedIndex)
      {
        setState(() {
          _selectedIndex=selectedIndex;
        });
      },
      ),
    );
  }
}

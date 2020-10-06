import 'package:Meal_App/model/meal.dart';
import 'package:Meal_App/widget/main_drawer.dart';
import 'package:flutter/material.dart';
import './favourite_screen.dart';
import 'package:Meal_App/screens/category_screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  const TabScreen(this.favouriteMeals);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> pages;

  // we initializing the pages in initstate lifecycle because, widget isnt available before that
  // so we cant really initialize before the build method runs. this is necessary for the favourite page.
  void initState() {
    pages = [
      {
        'page': CatagoriesScreen(),
        'title': 'category',
      },
      {
        'page': FavouriteScreen(widget.favouriteMeals),
        'title': 'Favourites',
      },
    ];
    super.initState();
  }

  int _selectPageIndex = 0;
  //index is automatically passed by flutter , it is the index of the tab that was selected
  void _selectpage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectPageIndex]['title']),
      ),
      //adding drawer
      drawer: Drawer(
        child: MainDrawer(),
      ),
      //pages is the list of the screens, and we get the selectpageindex value when we click on a tab. the selectpage method then setstate the value
      body: pages[_selectPageIndex]['page'],
      //this is what a botton navigation bar is called
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectpage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favourites'),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
        //styling the tabbar,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectPageIndex,
        //type: BottomNavigationBarType.shifting,
      ),
    );
  }
}

import 'package:Meal_App/model/meal.dart';
import 'package:Meal_App/screens/favourite_screen.dart';
import 'package:flutter/material.dart';
import './category_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  const TabsScreen(this.favouriteMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        // it will start with tab 1 selected, default is 0.
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Meal'),
            //the default controller and the tabbar here are automatically connected by flutter
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.category),
                  text: 'Categories',
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: 'Favourties',
                ),
              ],
            ),
          ),
          //we can have same number of child widget inside tabbarview,  as many tab we have on the tabbar
          body: TabBarView(
            children: <Widget>[
              CatagoriesScreen(),
              FavouriteScreen(widget.favouriteMeals),
            ],
          ),
        ));
  }
}

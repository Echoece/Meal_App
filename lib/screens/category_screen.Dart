import 'package:Meal_App/dummy_data.dart';
import 'package:flutter/material.dart';
import '../widget/category_item.dart';

//this class draws the categories in screen in a gridview.
class CatagoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  builder way= more performance boost
    // return GridView.builder(gridDelegate: null, itemBuilder: null);

    // we didnt return a scaffold widget here because its a part of the tab screen, the gridview only controls the lower screen where its the tabs end
    return GridView(
      padding: const EdgeInsets.all(25),
      children: DUMMY_CATEGORIES
          .map((e) => CategoryItem(e.id, e.title, e.color))
          .toList(),

      //design of our grid, Silever is just scrollable areas of screen, GridDelegate is responsible for structure,
      // withmaxacrossaxisextent is a preconfigured class which allows us to define a maximum width for each grid. then it will
      //automatically create as many columns as it can fit.
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          //height and width relation of the child
          childAspectRatio: 3 / 2,
          //means how much distance between our columns and rows in the grid
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
    );
  }
}

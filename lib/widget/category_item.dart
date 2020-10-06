import 'package:Meal_App/screens/category_meals_screen.dart';
import 'package:flutter/material.dart';

// this class returns the widget of the category menu
class CategoryItem extends StatelessWidget {
  final String title, id;
  final Color color;

  const CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext ctx) {
    // this class helps with navigating, here we using the routes system. here we pass the arguments
    // id and title to the constructor of the main dart file.
    Navigator.of(ctx).pushNamed(
      CategoryMealScreen.mealroute,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // we wrap the container with GesterDetector so we can use the ontap method which this wdiget provide. we can basically add  actionlistener
      // on this widget which is built in. In this case we used Inkwell widget, which is also a gesterdetector but fires a ripple
      // effect when we tap
      onTap: () {
        return selectCategory(context);
      },
      splashColor: Theme.of(context).primaryColor,
      // we match the border radius of the inkwell with the container borderradius , so that the ripple effect will match.
      borderRadius: BorderRadius.circular(15),

      child: Container(
        // we adding const here so fullter wont re render this each time
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(.7), color],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

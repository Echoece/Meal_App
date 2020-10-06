import 'package:Meal_App/model/meal.dart';
import 'package:flutter/material.dart';
import '../widget/meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> favouriteList;

  const FavouriteScreen(this.favouriteList);
  @override
  Widget build(BuildContext context) {
    // we didnt return a scaffold widget here , because the favouritescreen doesnt manage the entire page. it is part of the tab screen.
    // it only control the bottom part
    if (favouriteList.isEmpty) {
      return Center(
        child: Text('You Have no Favourites Yet- Lets Get Started!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            title: favouriteList[index].title,
            imageUrl: favouriteList[index].imageUrl,
            duration: favouriteList[index].duration,
            complexity: favouriteList[index].complexity,
            affordability: favouriteList[index].affordability,
            id: favouriteList[index].id,
          );
        },
        itemCount: favouriteList.length,
      );
    }
  }
}

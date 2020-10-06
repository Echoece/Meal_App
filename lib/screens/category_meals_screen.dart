import 'package:Meal_App/model/meal.dart';
import 'package:Meal_App/widget/meal_item.dart';
import 'package:flutter/material.dart';

//this class is the screen where we go when we click on a category. it will show image, recipe etc
class CategoryMealScreen extends StatefulWidget {
  static const mealroute = '/categorie-meals';
  final List<Meal> availableMeals;

  const CategoryMealScreen(this.availableMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  var _loadedinitData = false;

  /*
  @override
  void initState() {
    //extracting the arguments from the pushnamed route method from category_item class
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    // assigning the arguments to variable
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayMeals = DUMMY_MEALS
        .where((element) => element.categories.contains(categoryId))
        .toList();
    super.initState();
  }
  */

  // here we used this lifecycle method because initstate runs too early to have the Context variable available. so using the ModalRoute.of(context)
  // would give us error. thats why  used this method.
  @override
  void didChangeDependencies() {
    // we using this check here , because this method runs few times in its lifecycle. so it will reset everytime.
    // by having this bool check we can fix that problem. here the code will only run for the first time.
    if (!_loadedinitData) {
      //extracting the arguments from the pushnamed route method from category_item class
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      // assigning the arguments to variable
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayMeals = widget.availableMeals
          .where((element) => element.categories.contains(categoryId))
          .toList();
      _loadedinitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(
      () {
        displayMeals.removeWhere((element) => element.id == mealId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            title: displayMeals[index].title,
            imageUrl: displayMeals[index].imageUrl,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
            id: displayMeals[index].id,
            //removeitem: _removeMeal,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}

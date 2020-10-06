import 'package:Meal_App/dummy_data.dart';
import 'package:Meal_App/model/meal.dart';
import 'package:Meal_App/screens/category_meals_screen.dart';
import 'package:Meal_App/screens/filter_screen.dart';
import 'package:Meal_App/screens/meal_details_screen.dart';
import 'package:flutter/material.dart';
import './screens/meal_details_screen.dart';
import 'screens/tabbottom_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // an empty favouritemeal list for keeping track of the favourite meals
  List<Meal> _favouriteMeals = [];
  // filtering map for the filter screen
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'Vegeterian': false,
    'vegan': false
  };
  // filtered list
  List<Meal> _availablemeals = DUMMY_MEALS;
  // filter method
  void setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availablemeals = DUMMY_MEALS.where(
        (element) {
          // if the filter gluten is active,  and the meal glutenfree property is not true, then it will be excluded.
          //same logic in the rest three as well
          if (_filters['gluten'] && !element.isGlutenFree) {
            return false;
          }
          if (_filters['lactose'] && !element.isLactoseFree) {
            return false;
          }
          if (_filters['Vegeterian'] && !element.isVegetarian) {
            return false;
          }
          if (_filters['vegan'] && !element.isVegan) {
            return false;
          }
          // if the meal  doesnt meet any requirement, it will return true and be kept in the list of meals.
          return true;
        },
      ).toList();
    });
  }

  // method for toggling the favourite list button\
  void _toggleFavourite(String mealID) {
    // checking if the mealID is already in the favourite meal
    final existingIndex =
        _favouriteMeals.indexWhere((element) => element.id == mealID);
    // if its present in the favouriteList, we are removing it
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    }
    // if not present we add the meal to the list
    else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealID));
      });
    }
  }

  //method for checking if the mealId is fav or not
  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(220, 210, 23, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // home: CatagoriesScreen(),

      // route table takes a map, which takes a string keys which identify a route. and
      // the value is our creatiion function for this screen. ctx is provied by dart already. we getting the arguments actually from the calling function
      // from the category_item.dart

      // here we using static variable as routename because its less error prone due to typing mistake

      // initialRoute: '/',its default so reduntant , just wrote it to explain
      routes: {
        // we are sending the favouritemeals list to tabscreen, because thats where we can get access to the filter screen and
        // send the list to filterscreen
        '/': (ctx) => TabScreen(_favouriteMeals),

        //this is for the tabscreen on top
        /*
        '/': (ctx) => TabsScreen(),
        */
        CategoryMealScreen.mealroute: (ctx) =>
            CategoryMealScreen(_availablemeals),
        MealDetails.routename: (ctx) =>
            MealDetails(_toggleFavourite, _isMealFavourite),
        FilterScreen.routName: (ctx) => FilterScreen(_filters, setFilters),
      },

      // these are two properties we dont need in some applications, but in some cases it can be used.

      // this is when we get a route dynamically, but its not registered in the routes on main.dart. We also get a setttings argument here, which gives us access
      // to settings.name or setting.arguments etc and we can do stuff with it
      onGenerateRoute: (settings) {
        /*
        if(settings.name == '/meal-screen'){
          return ....
        }
        else if(settings.name == 'something else'){
          return ...
        }
        */
        return MaterialPageRoute(
            builder: (ctx) => CategoryMealScreen(_availablemeals));
      },
      // this is used when flutter fail to find any other routes, either from routes or ongenerateroute
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => CategoryMealScreen(_availablemeals));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:Meal_App/dummy_data.dart';

class MealDetails extends StatelessWidget {
  static const routename = '/meal-detail';
  final Function toggleFavourite;
  final Function _isMealFavourite;

  MealDetails(this.toggleFavourite, this._isMealFavourite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget childin) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white30, border: Border.all(color: Colors.grey)),
      height: 200,
      width: 300,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: childin,
    );
  }

  @override
  Widget build(BuildContext context) {
    //getting the arguments from the routeargument
    final mealId = ModalRoute.of(context).settings.arguments as String;
    // getting the image ura from the database,
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      //wrapping the column with a singlechildscrollview becaues otherwise we were getting overflow error
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //container for the image of the food
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            //container for the title of the food
            buildSectionTitle(context, selectedMeal.title),

            //we cant place a Listview here cause a listview by default has infinite height, and the parent widget, column try to take
            // as much height as possible. so it would  give an error. thats why we wrap it in container.
            buildSectionTitle(context, 'Ingredients'),
            //container for ingredients
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(selectedMeal.ingredients[index]),
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            )),

            //steps
            buildSectionTitle(context, 'Steps'),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Text('#${index + 1}'),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  //this will provide a horizontal line
                  Divider(
                    color: Colors.black,
                  ),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ))
          ],
        ),
      ),
      //this button pop the screen from the stack, so essentially we go back to the previous screen.
      // this is an important concept, we are passing data back to another screen here.
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(mealId);
        },
        child: Icon(Icons.delete),
      ),
      */
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavourite(mealId),
        // two icons for fav and non fav meals
        child: Icon(_isMealFavourite(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}

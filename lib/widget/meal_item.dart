import 'package:Meal_App/model/meal.dart';
import 'package:Meal_App/screens/meal_details_screen.dart';
import 'package:flutter/material.dart';

class MealItem extends StatelessWidget {
  final String title, imageUrl, id;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  //final Function removeitem;

  void selectMeal(BuildContext context) {
    //pushnamed returns a future type , so we can use then here
    Navigator.of(context)
        .pushNamed(
          MealDetails.routename,
          // getting the data from the poped page from stack, in this case
          // the argument coming from the meal_deatail_screen file, from the floatingactionbutton onpressed method.
          // there we pass a data and pop the page from the stack, but we can catch the arguement here. because
          // pushnamed returns a Future<T> ,
          arguments: id,
        )
        .then(
          (value) => {
            if (value != null)
              {
                //removeitem(value),
              },
          },
        );
  }

  MealItem({
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.id,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'simple';
        break;
      case Complexity.Challenging:
        return 'challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Uknowns';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      default:
        return 'Uknowns';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                //image , this widget takes a widget as a child and force it into a certain shape
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // title, we used positioned , this is only available in stack. and we can define the position here.
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 320,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text('$duration min'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ),
                      Text(complexityText),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ),
                      Text(' $affordabilityText'),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

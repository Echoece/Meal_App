import 'package:Meal_App/screens/filter_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icondata, Function onTapHandler) {
    return ListTile(
      leading: Icon(
        icondata,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: onTapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          //heading container
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking up',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // list of buttons, listtile have ontap argument that we can use

          // we  using pushreplacedmentNamed because otherwise the screens would be on the stack indefinately as  many times as we click.
          // so this will keep only the current screen we keep and remove the last screen from the stack.
          // this method replace the existing page instead of pushing the new page on the stack

          buildListTile(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListTile(
            'Filter',
            Icons.settings,
            () {
              Navigator.of(context).pushReplacementNamed(FilterScreen.routName);
            },
          ),
        ],
      ),
    );
  }
}

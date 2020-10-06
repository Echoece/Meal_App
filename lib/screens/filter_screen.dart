import 'package:Meal_App/widget/main_drawer.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const routName = '/filters';
  final Function savedFilter;
  final Map<String, bool> _filters;

  const FilterScreen(this._filters, this.savedFilter);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree;
  var _vegetarian;
  var _vegan;
  var _lactoseFree;

  @override
  initState() {
    _glutenFree = widget._filters['gluten'];
    _lactoseFree = widget._filters['lactose'];
    _vegetarian = widget._filters['Vegeterian'];
    _vegan = widget._filters['vegan'];
    super.initState();
  }

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updatevalue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updatevalue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filtered Recipes'),
          //widget is a built in flutter function that let us access the widget elements that we cant access otherwise
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Map<String, bool> _filters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'Vegeterian': _vegetarian,
                  'vegan': _vegan,
                };

                widget.savedFilter(_filters);
              },
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your criteria',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  buildSwitchListTile(
                    'Glten Free',
                    'Only Include gluten-free meals',
                    _glutenFree,
                    (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    'lactose Free',
                    'Only Include lactose-free meals',
                    _lactoseFree,
                    (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    'Vegeterian Free',
                    'Only Include vegeterian-free meals',
                    _vegetarian,
                    (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    'Vegan Free',
                    'Only Include vegan-free meals',
                    _vegan,
                    (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

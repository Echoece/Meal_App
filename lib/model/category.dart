import 'package:flutter/material.dart';

//category model class
class Category {
  final String id, title;
  final Color color;
//we add const , that means all the object that are created wont be changed. without adding this const
// we would be having error in the dummy data file where we were trying to assign a const object there.
  const Category(
      {@required this.id, @required this.title, this.color = Colors.orange});
}

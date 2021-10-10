
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news_app/pages/projets/detailprojet.dart';

// ignore: must_be_immutable
class ProjectCard extends StatelessWidget {
  var _name;
  var _description;
  var _author;
  var amount;
  //var _imageUrl;
  var _bgColor;

  ProjectCard(this._name, this._author, this._description,this.amount, this._bgColor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetails(_name, _description, _author,amount),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(MdiIcons.accountHardHat),
            title: Text(
              _name,
              style: TextStyle(
                color:Color(0xff1E1C61),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _author,
              style: TextStyle(
                color:Color(0xff1E1C61).withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

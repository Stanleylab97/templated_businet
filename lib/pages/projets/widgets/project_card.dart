import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news_app/pages/projets/detailprojet.dart';

// ignore: must_be_immutable
class ProjectCard extends StatelessWidget {
  var _name;
  var _description;
  var _author;
  var amount;
  var secteur;
  var createdAt;
  //var _imageUrl;
  var _bgColor;

  ProjectCard(
      this._name, this._author, this._description, this.amount, this.secteur, this.createdAt);

  @override
  Widget build(BuildContext context) {
    Color setColor(String secteur) {
      Color color;
      if (secteur == "Fine-Tech") {
        return color = Colors.blue[700];
      } else if (secteur == "Agriculture") {
        return color = Colors.green;
      } else if (secteur == "Élevage") {
        return color = Colors.purple;
      } else if (secteur == "Humanitaire") {
        return color = Colors.blueAccent[200];
      } else
        return color = Colors.grey.shade400;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProjectDetails(_name, _description, _author, amount, secteur,createdAt),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.blue[300].withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(MdiIcons.accountHardHat),
            title: Text(
              _name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => setColor(secteur)),
                  shape: MaterialStateProperty.resolveWith((states) =>
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)))),
              child: Text(secteur,
                  style: TextStyle(color: Colors.black87, fontSize: 13)),
              onPressed: () {},
            ),
            subtitle: Text(
              _description,
              maxLines: 2,
              style: TextStyle(
                color: Color(0xff1E1C61).withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

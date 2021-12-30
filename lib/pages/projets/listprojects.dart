import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:news_app/pages/projets/widgets/project_card.dart';
import 'package:news_app/pages/projets/widgets/projets_state_card.dart';
import 'package:news_app/widgets/circle_button.dart';
import './createproject.dart';
import 'package:news_app/config/utils.dart' as duration;

class Projets extends StatefulWidget {
  @override
  _ProjetsState createState() => _ProjetsState();
}

class _ProjetsState extends State<Projets> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isMenuClosed = true;
  double screenWidth;

  Widget circularImage() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/icons/longLogo.png"))),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    buildCategoryList() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 30,
            ),
            CategoryCard(
              'Tout',
              'assets/icons/all.png',
              Color(0xff4B7FFB),
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCard(
              'En cours',
              'assets/icons/processing.png',
              Color(0xffFFB167),
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCard(
              'Terminés',
              'assets/icons/end.png',
              Color(0xffEF716B),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      );
    }

    buildProjectWidget(String nom, String createdAt, String author,
        String description, int amount, String secteur) {
      final f = new DateFormat('dd-MM-yyyy HH:mm');
      /* f
            .format(DateTime.fromMillisecondsSinceEpoch(
                datecreation.seconds * 1000))
            .toString(), */
      return Column(children: <Widget>[
        ProjectCard(
          nom,
          author,
          description,
          amount,
          secteur,
          createdAt,
        ),
        SizedBox(
          height: 5,
        )
      ]);
    }

    buildDoctorList(BuildContext context) {
      return SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height * .69,
              child: StreamBuilder(
                  stream: firestore.collection("Projects").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          'Veuillez réessayer plus tard. Un léger soucis de connexion');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        var x = snapshot.data.docs[index]['createdAt'];
                        print("CreatedAt: $x");
                        return buildProjectWidget(
                            snapshot.data.docs[index]['nom'],
                            duration.Utils.getPublishedDateFromTimestamp(
                                snapshot.data.docs[index]['createdAt']),
                            snapshot.data.docs[index]['createdBy'],
                            snapshot.data.docs[index]['description'],
                            snapshot.data.docs[index]['needAmount'],
                            snapshot.data.docs[index]['secteur']);
                      },
                    );
                  })));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Projets', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => print('Search'),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: ListView(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Consulter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1E1C61),
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
              ],
            ),
            buildDoctorList(context),
          ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateProject()));
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text('Ajouter', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            foregroundColor: Colors.red[400]));
  }
}

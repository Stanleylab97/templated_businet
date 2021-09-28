/* import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import './createproject.dart';

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
              Palette.kBlueColor,
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCard(
              'En cours',
              'assets/icons/processing.png',
              Palette.kYellowColor,
            ),
            SizedBox(
              width: 10,
            ),
            CategoryCard(
              'Terminés',
              'assets/icons/end.png',
              Palette.kOrangeColor,
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      );
    }

    buildProjectWidget(
        String nom, String author, String description, int amount) {
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
          Color(0xff4B7FFB),
        ),
        SizedBox(
          height: 5,
        )
      ]);
    }

    buildDoctorList(BuildContext context) {
      return Expanded(
          child: SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height * .49,
                  child: StreamBuilder(
                      stream: firestore.collection("Projects").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Veuillez réessayer plus tard. Un léger soucis de connexion');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return Expanded(
                          child: Center(
                            child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return buildProjectWidget(
                                    snapshot.data.docs[index]['nom'],
                                    snapshot.data.docs[index]['createdBy'],
                                    snapshot.data.docs[index]['description'],
                                    snapshot.data.docs[index]['needAmount']);
                              },
                            ),
                          ),
                        );
                      }))));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(Icons.),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Catégories',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1E1C61),
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                buildCategoryList(),
                SizedBox(
                  height: size.height * 0.005,
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
 */
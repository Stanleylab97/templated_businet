import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/pages/investisseur/ui/component/appBar.dart';
import 'package:news_app/pages/investisseur/ui/screen/validatedprojectdetails.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ValidatedProjects extends StatefulWidget {
  const ValidatedProjects({Key key}) : super(key: key);

  @override
  _ValidatedProjectsState createState() => _ValidatedProjectsState();
}

class _ValidatedProjectsState extends State<ValidatedProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: appBar(
          left: Icon(Icons.verified, color: Colors.black54),
          title: 'Projets validés',
          right: Icon(Icons.zoom_in, color: Colors.black54)), */
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Projects")
            .where("validated", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
                'Veuillez réessayer plus tard. Un léger soucis de connexion');
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text('Pas de projets validés en attentes'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final x = snapshot.data.docs.length;
          print("Record lenght: $x");

          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data.docs[index];
                return (index % 2 == 0)
                    ? InkWell(
                        child: ValidatedLeft(doc: doc),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ValidatedProjectDetails(doc: doc),
                            ),
                          );
                        })
                    : InkWell(
                        child: ValidatedRight(doc: doc),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ValidatedProjectDetails(doc: doc),
                            ),
                          );
                        });
              });
        },
      ),
    );
  }
}

class ValidatedLeft extends StatelessWidget {
  const ValidatedLeft({
    Key key,
    @required this.doc,
  }) : super(key: key);

  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 2, top: 2),
        height: 120,
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(80.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    offset: Offset(-10.0, 0.0),
                    blurRadius: 20.0,
                    spreadRadius: 4.0)
              ]),
          padding: EdgeInsets.only(left: 32, top: 10.0, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doc["nom"],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "Secteur:" + doc["secteur"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                "Budget :" + doc["needAmount"].toString() + " F CFA",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width * 0.6,
                  animation: true,
                  lineHeight: 15.0,
                  trailing: Status(
                    icon: Icons.remove_red_eye,
                    total: 10.toString(),
                  ),
                  animationDuration: 2500,
                  percent: doc['collectedAmount'] / doc["needAmount"],
                  center: Text(
                      ((doc['collectedAmount'] / doc["needAmount"]) * 100)
                              .toString() +
                          "%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.orange,
                ),
              ),
            ],
          ),
        ));
  }
}

class ValidatedRight extends StatelessWidget {
  const ValidatedRight({
    Key key,
    @required this.doc,
  }) : super(key: key);

  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 2, top: 2),
        height: 120,
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(topRight: Radius.circular(80.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    offset: Offset(-10.0, 0.0),
                    blurRadius: 20.0,
                    spreadRadius: 4.0)
              ]),
          padding: EdgeInsets.only(left: 32, top: 10.0, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doc["nom"],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "Secteur:" + doc["secteur"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                "Budget :" + doc["needAmount"].toString() + " F CFA",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width * 0.55,
                  animation: true,
                  trailing: Status(
                    icon: Icons.remove_red_eye,
                    total: 1000.toString() + "k",
                  ),
                  lineHeight: 15.0,
                  animationDuration: 2500,
                  percent: doc['collectedAmount'] / doc["needAmount"],
                  center: Text(
                      ((doc['collectedAmount'] / doc["needAmount"]) * 100)
                              .toString() +
                          "%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.orange,
                ),
              ),
            ],
          ),
        ));
  }
}

class Status extends StatelessWidget {
  final IconData icon;
  final String total;
  Status({this.icon, this.total});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 2,
        ),
        Icon(
          icon,
          color: Colors.white,
          size: 16,
        ),
        SizedBox(width: 4.0),
        Text(total, style: kDetailContent),
      ],
    );
  }
}

var kDetailContent = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 14.0,
    color: Colors.white,
  ),
);

const kGrey2 = Color(0xFF6D6D6D);

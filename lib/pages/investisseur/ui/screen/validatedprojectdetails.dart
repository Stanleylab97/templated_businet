import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/utils/snacbar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../component/button.dart';
import '../component/constants.dart';
import '../component/widget_functions.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ValidatedProjectDetails extends StatefulWidget {
  final DocumentSnapshot doc;
  const ValidatedProjectDetails({this.doc});

  @override
  _ValidatedProjectDetailsState createState() =>
      _ValidatedProjectDetailsState();
}

class _ValidatedProjectDetailsState extends State<ValidatedProjectDetails> {
  final GlobalKey<SlideActionState> _buttonKey = GlobalKey<SlideActionState>();
  bool addedToCart = false; // Just for Demonstration
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var pourcentage =
        ((widget.doc['collectedAmount'] / widget.doc["needAmount"]) * 100);
    print("pourcentage: $pourcentage");
    String v = pourcentage.toStringAsFixed(2);

    final TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.40,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffE2F3D4),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/projet.jpg",
                                    width: constraints.maxWidth * 0.50,
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  left: 10,
                                  child: SquareIconButton(
                                    icon: Icons.arrow_back_ios_outlined,
                                    width: 50,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    buttonColor: Colors.orange.shade100,
                                    iconColor: Colors.orange,
                                  ))
                            ],
                          ),
                        ),
                        addVerticalSpace(10),
                        Container(
                          color: Colors.grey.shade50,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    addVerticalSpace(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.doc['nom'],
                                              style: textTheme.headline5,
                                            ),
                                            addVerticalSpace(5),
                                            RichText(
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .monetization_on_rounded,
                                                          color: Colors.green,
                                                          size: 15)),
                                                  TextSpan(
                                                      text: "Budget: " +
                                                          widget
                                                              .doc['needAmount']
                                                              .toString() +
                                                          " F CFA",
                                                      style: textTheme.subtitle2
                                                          .apply(
                                                              color:
                                                                  COLOR_GREY))
                                                ])),
                                            addVerticalSpace(5),
                                            RichText(
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .monetization_on_rounded,
                                                          color: Colors.red,
                                                          size: 15)),
                                                  TextSpan(
                                                      text: "Manquant :" +
                                                          (widget.doc['needAmount'] -
                                                                  widget.doc[
                                                                      'collectedAmount'])
                                                              .toString() +
                                                          " F CFA",
                                                      style: textTheme.subtitle2
                                                          .apply(
                                                              color:
                                                                  COLOR_GREY))
                                                ])),
                                          ],
                                        ),
                                      ],
                                    ),
                                    addVerticalSpace(20),
                                    Divider(),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(children: [
                                                WidgetSpan(
                                                    child: Icon(Icons.star,
                                                        color: Colors.orange,
                                                        size: 15)),
                                                TextSpan(
                                                    text: widget.doc['secteur'],
                                                    style: textTheme.bodyText2
                                                        .apply(
                                                            fontWeightDelta: 4))
                                              ])),
                                          /*       RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(children: [
                                                WidgetSpan(
                                                    child: Icon(
                                                        Icons.access_time_sharp,
                                                        color: Colors.red,
                                                        size: 15)),
                                                TextSpan(
                                                    text: " 18 Mins",
                                                    style: textTheme.bodyText2
                                                        .apply(
                                                            fontWeightDelta: 4))
                                              ])), */
                                          RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(children: [
                                                WidgetSpan(
                                                    child: Icon(
                                                        Icons.remove_red_eye,
                                                        color: Colors.green,
                                                        size: 15)),
                                                TextSpan(
                                                    text: "2.3 K",
                                                    style: textTheme.bodyText2
                                                        .apply(
                                                            fontWeightDelta: 4))
                                              ])),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Text(
                                      "Description",
                                      style: textTheme.headline6,
                                    ),
                                    addVerticalSpace(10),
                                    Text(
                                      "${widget.doc['description']}",
                                      style: textTheme.subtitle2
                                          .apply(heightDelta: 2.0),
                                    ),
                                    addVerticalSpace(100),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: -35,
                                right: 20,
                                child: InkWell(
                                  onTap: () {
                                    // Fluttertoast.showToast(msg: "Added to Favorite");
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // color: Colors.red,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 10.0,
                                              spreadRadius: 5.0)
                                        ]),
                                    child: CircularPercentIndicator(
                                      radius: 60.0,
                                      lineWidth: 8.0,
                                      animation: true,
                                      percent: widget.doc['collectedAmount'] /
                                          widget.doc["needAmount"],
                                      center: new Text(
                                        v.toString() + "%",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0),
                                      ),
                                      footer: new Text(
                                        "Collecté",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.yellow[700],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!addedToCart) ...[
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SlideAction(
                          text: "Investir",
                          key: _buttonKey,
                          sliderButtonIcon: Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                          ),
                          onSubmit: () {
                            Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                addedToCart = true;
                              });
                              // _buttonKey.currentState!.reset();
                               openSnacbar(_scaffoldKey, 'Pas de connexion internet');
                            });
                          },
                          // sliderRotate: false,
                          borderRadius: 10.0,
                          elevation: 0,
                          innerColor: COLOR_GREEN,
                          outerColor: Colors.grey.shade100,
                        ),
                      ),
                    ),
                  )
                ]
              ],
            ),
          );
        }),
      ),
    );
  }
}

/*import 'package:africa_businet/Config/palette.dart';
import 'package:africa_businet/Screens/messenging/callscreens/video_call.dart';
import 'package:africa_businet/Screens/messenging/callscreens/voice_call.dart';
import 'package:africa_businet/services/agora_token.dart'; */
//import 'package:africa_businet/widgets/projects/schedule_card.dart';
//import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProjectDetails extends StatelessWidget {
  var _name;
  var _description;
  var _author;
  var _amount;
  var _secteur;
  var _createdAt;

  //var _imageUrl;

  ProjectDetails(this._name, this._description, this._author, this._amount,
      this._secteur, this._createdAt);

  Future<String> takeMyAgoraToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('TokenAgora');
    return token;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _handleCameraAndMic(Permission permission) async {
      final status = await permission.request();
      print(status);
    }

    Future<void> onJoin() async {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Placeholder()
            /*  VideoCall(
            token: prefs.get('AGORATOKEN'),
            channelName: prefs.get('Channel'),
            role: ClientRole.Broadcaster,
          ), */
            ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
            height: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Text(
              "Retour",
              style: TextStyle(
                  fontSize: 24.0, color: Colors.white, fontFamily: "HelixBold"),
            )),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: IconButton(
                          icon: Icon(Icons.graphic_eq_sharp,
                              color: Colors.white, size: 20),
                          onPressed: () {},
                        ))),
                Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text("Projet: " + _name,
                        maxLines: 2,
                        style:
                            TextStyle(fontSize: 28, fontFamily: "HelixBold"))),
                SizedBox(height: 26.0),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Budget : ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "HelixBold",
                          )),
                      TextSpan(
                          text: "$_amount",
                          style: TextStyle(
                              fontSize: 26.0,
                              fontFamily: "HelixBold",
                              color: Colors.red)),
                      TextSpan(
                          text: "XOF",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "HelixBold",
                              color: Colors.red))
                    ],
                  ),
                ),
                SizedBox(height: 24),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Secteur: ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                  fontFamily: "HellixBold"),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(_secteur,
                                style: TextStyle(
                                    fontSize: 20.0, fontFamily: "HellixBold")),
                            SizedBox(
                              height: 36.0,
                            ),
                            Text(
                              "Promoteur: ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                  fontFamily: "HellixBold"),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(_author,
                                style: TextStyle(
                                    fontSize: 20.0, fontFamily: "HellixBold")),
                            SizedBox(
                              height: 36.0,
                            ),
                            Text(
                              "Date de publication: ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                  fontFamily: "HellixBold"),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(_createdAt,
                                style: TextStyle(
                                    fontSize: 20.0, fontFamily: "HellixBold")),
                          ],
                        ),
                      ),
                      CircleAvatar(
                          radius: 120,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: CachedNetworkImageProvider(
                              "https://images.pexels.com/photos/5922212/pexels-photo-5922212.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text("Description",
                    style: TextStyle(fontSize: 24.0, fontFamily: "HellixBold")),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 20),
                  child: Text(_description,
                      style:
                          TextStyle(fontSize: 16.0, fontFamily: "HellixBold")),
                ),
              ],
            ),
          ),
        )

        /* SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/detail_illustration.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child:
                      Placeholder() /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icons/back.svg',
                        height: 18,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/3dots.svg',
                      height: 18,
                    ),
                  ],
                ), */
                  ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              /* Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Palette.kBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(MdiIcons.accountHardHat),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Palette.kTitleTextColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _author,
                                maxLines: 3,
                                style: TextStyle(
                                  color:
                                      Palette.kTitleTextColor.withOpacity(0.7),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                      onTap: () async {
                                        print("AGORATOKEN");
                                      /*   SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        print(prefs.get('AGORATOKEN'));
                                        //var token=prefs.get('AGORATOKEN');
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => VoiceCall(
                                                    token:
                                                        prefs.get('AGORATOKEN'),
                                                    channel:
                                                        prefs.get('Channel')))); */
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Palette.kBlueColor
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/phone.svg',
                                        ),
                                      )),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color:
                                          Palette.kYellowColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      MdiIcons.facebookMessenger,
                                      color: Palette.facebookBlue,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        onJoin();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Palette.kOrangeColor
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/video.svg',
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Montant requis : " + _amount.toString() + " FCFA",
                        style: TextStyle(
                          color: Palette.kTitleTextColor.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'A propos du projet',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Palette.kTitleTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _description,
                        style: TextStyle(
                          height: 1.6,
                          color: Palette.kTitleTextColor.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      /* Text(
                        'Upcoming Schedules',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Palette.kTitleTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ScheduleCard(
                        'Consultation',
                        'Sunday . 9am - 11am',
                        '12',
                        'Jan',
                        Palette.kBlueColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ScheduleCard(
                        'Consultation',
                        'Sunday . 9am - 11am',
                        '13',
                        'Jan',
                        Palette.kYellowColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ScheduleCard(
                        'Consultation',
                        'Sunday . 9am - 11am',
                        '14',
                        'Jan',
                        Palette.kOrangeColor,
                      ),
                      SizedBox(
                        height: 20,
                      ), */
                    ],
                  ),
                ),
              ) */
            ],
          ),
        ),
      ), */
        );
  }
}

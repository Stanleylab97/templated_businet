import 'package:flutter/material.dart';
import 'package:news_app/config/config.dart';
import 'package:news_app/pages/welcome.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/sign_in_bloc.dart';
import '../utils/next_screen.dart';
import 'home.dart';
import 'investisseur/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String x;
  afterSplash() {
    final SignInBloc sb = context.read<SignInBloc>();
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      if (sb.isSignedIn == true || sb.guestUser == true) {
        /* FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if (doc.id == FirebaseAuth.instance.currentUser.uid) {
              print(doc["category"]);
              this.x = doc["category"].toString();
              print('Rec: ${this.x}'); */

       redirectUser();
       

        /*    });
        }); */

      } else
        gotoSignInPage();
    });
  }

  Future redirectUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String cat= sp.getString('category');
    if (cat == "Entrepreneur") {
        print("Message: $cat");
        nextScreenReplace(context, HomePage());
            } else {
              nextScreenReplace(context, Dasshboard());
            }
    }

  gotoHomePage() {
    final SignInBloc sb = context.read<SignInBloc>();
    if (sb.isSignedIn == true) {
      sb.getDataFromSp();
    }
    nextScreenReplace(context, HomePage());
  }

  gotoSignInPage() {
    nextScreenReplace(context, WelcomePage());
  }

  @override
  void initState() {
    afterSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
            child: Image(
          image: AssetImage(Config().splashIcon),
          height: 120,
          width: 120,
          fit: BoxFit.contain,
        )));
  }
}

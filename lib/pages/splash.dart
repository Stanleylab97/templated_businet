import 'package:flutter/material.dart';
import 'package:news_app/config/config.dart';
import 'package:news_app/pages/welcome.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/sign_in_bloc.dart';
import '../utils/next_screen.dart';
import 'home.dart';
import 'investisseur/dashboard.dart';

class SplashPage extends StatefulWidget {
  
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String x;
  afterSplash() {
    final SignInBloc sb = context.read<SignInBloc>();
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      if (sb.isSignedIn == true || sb.guestUser == true) {
        getCategory();
        if (this.x == "Investisseur") {
          nextScreenReplace(context, Dasshboard());
        } else {
          nextScreenReplace(context, HomePage());
        }
      } else
        gotoSignInPage();
    });
  }

 Future getCategory() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    this.x = sp.getString('category');
    String y = this.x;
    print("Categorie: $y");
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

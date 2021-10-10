import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/config/config.dart';
import 'package:news_app/pages/intro.dart';
import 'package:news_app/utils/next_screen.dart';
import 'package:news_app/pages/home.dart';


class DonePage extends StatefulWidget {
  final String prev;
  const DonePage({Key key, this.prev}) : super(key: key);

  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2000)).then((value) {
      if (widget.prev == "SignIn")
        nextScreenCloseOthers(context, HomePage());
      else
        nextScreenCloseOthers(context, IntroPage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Lottie.asset(Config().doneAsset,
            alignment: Alignment.center,
            fit: BoxFit.cover,
            height: 200,
            width: 200,
            repeat: false),
      ),
    );
  }
}

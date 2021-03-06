import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/blocs/internet_bloc.dart';
import 'package:news_app/blocs/sign_in_bloc.dart';
import 'package:news_app/pages/done.dart';
import 'package:news_app/pages/forgot_password.dart';
import 'package:news_app/pages/sign_up.dart';
import 'package:news_app/utils/icons.dart';
import 'package:news_app/utils/next_screen.dart';
import 'package:news_app/utils/snacbar.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SignInPage extends StatefulWidget {
  final String tag,category;
  SignInPage({Key key, this.tag,this.category}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool offsecureText = true;
  Icon lockIcon = LockIcon().lock;
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool signInStart = false;
  bool signInComplete = false;
  String email;
  String pass;

  void lockPressed() {
    if (offsecureText == true) {
      setState(() {
        offsecureText = false;
        lockIcon = LockIcon().open;
      });
    } else {
      setState(() {
        offsecureText = true;
        lockIcon = LockIcon().lock;
      });
    }
  }

  handleSignInwithemailPassword() async {
    final InternetBloc ib = Provider.of<InternetBloc>(context, listen: false);
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    await ib.checkInternet();
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      FocusScope.of(context).requestFocus(new FocusNode());
  
      await ib.checkInternet();
      if (ib.hasInternet == false) {
        openSnacbar(_scaffoldKey, 'no internet'.tr());
      } else {
        setState(() {
          signInStart = true;
        });
        sb.signInwithEmailPassword(email, pass).then((_) async {
          if (sb.hasError == false) {
            sb
                .getUserDatafromFirebase(sb.uid)
                .then((value) => sb.guestSignout())
                .then((value) => sb
                    .saveDataToSP()
                    .then((value) => sb.setSignIn().then((value) {
                          setState(() {
                            signInComplete = true;
                          });
                          afterSignIn();
                        })));
          } else {
            setState(() {
              signInStart = false;
            });
            openSnacbar(_scaffoldKey, sb.errorCode);
          }
        });
      }
    }
  }

  afterSignIn() {
    if (widget.tag == null) {
      nextScreenReplace(
          context,
          DonePage(
            prev: "SignIn",
          ));
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: IconButton(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.keyboard_backspace),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Text('Connexion',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900))
                    .tr(),
                Text('Suivez les ??tapes',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).secondaryHeaderColor))
                    .tr(),
                SizedBox(
                  height: 80,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'username@mail.com',
                      labelText: 'Adresse e-mail'),
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.length == 0)
                      return "L'adresse e-mail ne peut rester vide";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: offsecureText,
                  controller: passCtrl,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    hintText: 'Entrez le mot de passe',
                    //prefixIcon: Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                        icon: lockIcon,
                        onPressed: () {
                          lockPressed();
                        }),
                  ),
                  validator: (String value) {
                    if (value.length == 0)
                      return "Le mot de passe ne peut rester vide";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      pass = value;
                    });
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      'Mot de passe oubli???',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ).tr(),
                    onPressed: () {
                      //nextScreen(context, ForgotPasswordPage());
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                    },
                  ),
                ),
                Container(
                  height: 45,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Theme.of(context).primaryColor)),
                      child: signInStart == false
                          ? Text('Connexion',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white))
                              .tr()
                          : signInComplete == false
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )
                              : Text('Connexion r??ussie !',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white))
                                  .tr(),
                      onPressed: () {
                        handleSignInwithemailPassword();
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Pas de compte?").tr(),
                    TextButton(
                      child: Text('Inscrivez-vous',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))
                          .tr(),
                      onPressed: () {
                        nextScreenReplace(context, SignUpPage(category:widget.category));
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }
}

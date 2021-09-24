import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/blocs/internet_bloc.dart';
import 'package:news_app/blocs/sign_in_bloc.dart';
import 'package:news_app/pages/done.dart';
import 'package:news_app/pages/sign_in.dart';
import 'package:news_app/utils/icons.dart';
import 'package:news_app/utils/next_screen.dart';
import 'package:news_app/utils/snacbar.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpPage extends StatefulWidget {
  final String tag;
  SignUpPage({Key key, this.tag}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool offsecureText = true;
  Icon lockIcon = LockIcon().lock;
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  List categories = ['Entrepreneur', 'Investisseur'];
  List secteurs = ['Agriculture', 'Humanitaire', 'Informatique'];

  String categoryChoose;

  String email;
  String pass;
  String name;
  bool signUpStarted = false;
  bool signUpCompleted = false;

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

  Future handleSignUpwithEmailPassword() async {
    final InternetBloc ib = Provider.of<InternetBloc>(context, listen: false);
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    await ib.checkInternet();
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      FocusScope.of(context).requestFocus(new FocusNode());
      await ib.checkInternet();
      if (ib.hasInternet == false) {
        openSnacbar(_scaffoldKey, 'Pas de connexion internet'.tr());
      } else {
        setState(() {
          signUpStarted = true;
        });
        sb
            .signUpwithEmailPassword(name, email, pass, categoryChoose)
            .then((_) async {
          if (sb.hasError == false) {
            sb.getTimestamp().then((value) => sb
                .saveToFirebase()
                .then((value) => sb.increaseUserCount())
                .then((value) => sb.guestSignout().then((value) => sb
                    .saveDataToSP()
                    .then((value) => sb.setSignIn().then((value) {
                          setState(() {
                            signUpCompleted = true;
                          });
                          afterSignUp();
                        })))));
          } else {
            setState(() {
              signUpStarted = false;
            });
            openSnacbar(_scaffoldKey, sb.errorCode);
          }
        });
      }
    }
  }

  afterSignUp() {
    if (widget.tag == null) {
      nextScreenReplace(context, DonePage());
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
                Text('Inscription',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900))
                    .tr(),
                Text('Suivez les étapes',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).secondaryHeaderColor))
                    .tr(),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameCtrl,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    hintText: 'Entrez votre nom',
                    //prefixIcon: Icon(Icons.person)
                  ),
                  validator: (String value) {
                    if (value.length == 0)
                      return "Le nom ne peut pas rester vide";
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'username@mail.com',
                    labelText: 'Adresse e-mail',
                  ),
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.length == 0)
                      return "L'adresse Email ne peut rester vide";
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
                  controller: passCtrl,
                  obscureText: offsecureText,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    hintText: 'Veuillez entrer votre mot de passe',
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
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(35.0)),
                  child: DropdownButton(
                      hint: Text(
                        'Selectionnez votre secteur',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      isExpanded: true,
                      underline: SizedBox(),
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).secondaryHeaderColor),
                      value: categoryChoose,
                      onChanged: (newValue) {
                        setState(() {
                          categoryChoose = newValue;
                        });
                      },
                      items: categories.map((valueItem) {
                        return DropdownMenuItem(
                            value: valueItem,
                            child: Text(
                              valueItem,
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ));
                      }).toList()),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Theme.of(context).primaryColor)),
                      child: signUpStarted == false
                          ? Text(
                              'Inscription',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ).tr()
                          : signUpCompleted == false
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white)
                              : Text('Inscription réussie !',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white))
                                  .tr(),
                      onPressed: () {
                        handleSignUpwithEmailPassword();
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Déjà inscrit ?').tr(),
                    TextButton(
                      child: Text(
                        'Se connecter',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ).tr(),
                      onPressed: () {
                        if (widget.tag == null) {
                          nextScreenReplace(context, SignInPage());
                        } else {
                          nextScreenReplace(
                              context,
                              SignInPage(
                                tag: 'Popup',
                              ));
                        }
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

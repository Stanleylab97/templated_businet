import 'package:news_app/config/palette.dart';
//import 'package:news_app/pages/projets/allprojects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flash/flash.dart';

class CreateProject extends StatefulWidget {
  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _autovalidate;
  TextEditingController _titreController;
  TextEditingController _fondController;
  TextEditingController _description;

  @override
  void initState() {
    super.initState();
    _autovalidate = false;
    _titreController = TextEditingController();
    _fondController = TextEditingController();
    _description = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajout de projet'),
        backgroundColor: Palette.kOrangeColor,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _key,
      autovalidate: _autovalidate,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Titre',
                filled: true,
                isDense: true,
              ),
              controller: _titreController,
              keyboardType: TextInputType.text,
              autocorrect: true,
              validator: _validateEmail,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Montant requis',
                filled: true,
                isDense: true,
              ),
              controller: _fondController,
              keyboardType: TextInputType.number,
              validator: _validateEmail,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                filled: true,
                isDense: true,
                border: InputBorder.none,
              ),
              controller: _description,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 12,
              autocorrect: true,
              validator: _validateEmail,
            ),
            const SizedBox(
              height: 16,
            ),
            RaisedButton(
                color: Palette.kOrangeColor,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0)),
                child: Text('ENREGISTRER'),
                onPressed: _validateFormAndLogin),
          ],
        ),
      ),
    );
  }

  String _validateRequired(String val, fieldName) {
    if (val == null || val == '') {
      return '$fieldName est requis';
    }
    return null;
  }

  String _validateEmail(String value) {
    if (value == null || value == '') {
      return 'Veuillez remplir les champs';
    }

    return null;
  }

  Future<void> _validateFormAndLogin() async {
    // Get form state from the global key
    var formState = _key.currentState;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // check if form is valid
    if (formState.validate()) {
      Map<String, dynamic> userDataMap = {
        "nom": _titreController.text,
        "needAmount": int.parse(_fondController.text),
        "createdAt": FieldValue.serverTimestamp(),
        "description": _description.text,
        "createdBy": prefs.get('USERNAMEKEY')
      };

      firestore
          .collection("Projects")
          .add(userDataMap)
          .then((value) => () {
                _titreController.clear();
                _fondController.clear();
                _description.clear();
               /*  context.showSuccessBar(
                    content: Text('Le projet a bien été sauvegardé')); */
                Navigator.pop(context);
              })
          .catchError((error) => () {
                var snackBar =
                    SnackBar(content: Text('Erreur lors de l\'enregistrement'));
              //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }); 
    } else {
      // show validation errors
      // setState forces our [State] to rebuild
      setState(() {
        _autovalidate = true;
      });
    }
  }
}

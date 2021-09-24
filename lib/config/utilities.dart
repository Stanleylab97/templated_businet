import 'dart:io';
import 'dart:math';
import 'package:news_app/config/enum/user_state.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Utils {
  static String getUsername(String email) {
    return "live:${email.split('@')[0]}";
  }

  static String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String firstNameInitial = nameSplit[0][0];
    String lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
  }

  // this is new

  static Future<File> pickImage({@required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    File selectedImage = await File(pickedFile.path);
    return await compressImage(selectedImage);
  }

  static Future<File> compressImage(File imageToCompress) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);

    Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
    Im.copyResize(image, width: 500, height: 500);

    return new File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  }

  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;

      case UserState.Online:
        return 1;

      default:
        return 2;
    }
  }

  static UserState numToState(int number) {
     switch (number) {
      case 0:
        return UserState.Offline;

      case 1:
        return UserState.Online;

      default:
        return UserState.Waiting;
    }
  }
}



class Shared {


  static String readTimestamp(Timestamp timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  var diff = now.difference(date);
  String time = '';
 
  if (diff.inSeconds < 60) {
    return time = 'Maintenant';
  } else if (diff.inMinutes > 0 && diff.inMinutes < 60) {
    if (diff.inMinutes == 1) {
     return time = diff.inMinutes.toString() + ' min';
    } else {
     return time = diff.inMinutes.toString() + ' min';
    }
  } else if (diff.inHours > 0 && diff.inHours < 24) {
    if (diff.inHours == 1) {
     return time = diff.inHours.toString() + ' heure';
    } else {
     return time = diff.inHours.toString() + ' heures';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
     return time = 'Il y a ' + diff.inDays.toString() + ' jour';
    } else {
     return time = 'Il y a ' + diff.inDays.toString() + ' jours';
    }
  } else {
    if (diff.inDays == 7) {
     return time = (diff.inDays / 7).floor().toString() + ' semaine';
    } else if (diff.inDays >= 7 && diff.inDays <30){
       return  time = (diff.inDays / 7).floor().toString() + ' semaines'; 
    } else if (diff.inDays  == 30 || diff.inDays  <= 364) {
       return time = (diff.inDays / 30).floor().toString() + ' mois';
      } else{
         return time = (diff.inDays / 364).floor().toString() + ' ans';
      }
    }
  }


}
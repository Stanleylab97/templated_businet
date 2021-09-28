import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news_app/blocs/ads_bloc.dart';
import 'package:news_app/blocs/notification_bloc.dart';
import 'package:news_app/pages/categories.dart';
import 'package:news_app/pages/explore.dart';
import 'package:news_app/pages/profile.dart';
import 'package:news_app/pages/videos.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:news_app/pages/projets/createproject.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  List<IconData> iconList = [
    Feather.home,
    Feather.message_circle,
    MdiIcons.accountHardHat,
    MdiIcons.bullhorn,
    Feather.user
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index,
        curve: Curves.easeIn, duration: Duration(milliseconds: 250));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((value) async {
      final adb = context.read<AdsBloc>();
      await context
          .read<NotificationBloc>()
          .initFirebasePushNotification(context)
          .then((value) =>
              context.read<NotificationBloc>().handleNotificationlength())
          .then((value) => adb.checkAdsEnable())
          .then((value) async {
        if (adb.interstitialAd == true || adb.bannerAd == true) {
          //FirebaseAdMob.instance.initialize(appId: Platform.isAndroid ? Config().admobAppIdAndroid : Config().admobAppIdiOS);  //admob
          //FacebookAudienceNetwork.init();  //fb

        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) => onTabTapped(index),
        currentIndex: _currentIndex,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        iconSize: 28,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(iconList[0]), label: 'Accueil'.tr()),
          BottomNavigationBarItem(
              icon: Icon(iconList[1]), label: 'Réseau'.tr()),
          BottomNavigationBarItem(
              icon: Icon(
                iconList[2],
                size: 25,
              ),
              label: 'Projets'.tr()),
          BottomNavigationBarItem(icon: Icon(iconList[4]), label: 'Profil'.tr())
        ],
      ),
      body: PageView(
        controller: _pageController,
        allowImplicitScrolling: false,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Explore(),
          Placeholder(),
          CreateProject(),
          //Categories(),
          ProfilePage()
        ],
      ),
    );
  }
}

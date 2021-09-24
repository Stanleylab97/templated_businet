import 'package:flutter/material.dart';
import 'package:news_app/pages/investisseur/ui/screen/home.dart';
import 'package:news_app/pages/investisseur/ui/screen/validatedprojects.dart';

import 'ui/component/appBar.dart';

class Dasshboard extends StatefulWidget {
  const Dasshboard({Key key}) : super(key: key);

  @override
  _DasshboardState createState() => _DasshboardState();
}

enum TabItem { home, done, explore, notification, setting }

class _DasshboardState extends State<Dasshboard> {
  TabItem _currentItem = TabItem.home;
  final List<TabItem> _bottomTabs = [
    TabItem.home,
    TabItem.done,
    TabItem.explore,
    TabItem.notification,
    TabItem.setting
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: _buildScreen(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: _bottomTabs
          .map((tabItem) => _bottomNavigationBarItem(_icon(tabItem), tabItem))
          .toList(),
      onTap: _onSelectTab,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      IconData icon, TabItem tabItem) {
    final Color color =
        _currentItem == tabItem ? Colors.black54 : Colors.black26;

    return BottomNavigationBarItem(icon: Icon(icon, color: color), label: '');
  }

  void _onSelectTab(int index) {
    TabItem selectedTabItem = _bottomTabs[index];

    setState(() {
      _currentItem = selectedTabItem;
    });
  }

  IconData _icon(TabItem item) {
    switch (item) {
      case TabItem.home:
        return Icons.account_balance_wallet;
      case TabItem.done:
        return Icons.verified;
      case TabItem.explore:
        return Icons.explore;
      case TabItem.notification:
        return Icons.notifications;
      case TabItem.setting:
        return Icons.settings;
      default:
        throw 'Unknown $item';
    }
  }

  Widget _buildScreen() {
    switch (_currentItem) {
      case TabItem.home:
        return HomeScreen();
      case TabItem.done:
        return ValidatedProjects();
      case TabItem.explore:
        return Placeholder();
      case TabItem.notification:
        return Placeholder();
      case TabItem.setting:
        return Placeholder();
      default:
        return Placeholder();
    }
  }
}

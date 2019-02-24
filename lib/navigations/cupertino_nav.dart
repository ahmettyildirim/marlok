import 'package:flutter/cupertino.dart';
import 'package:marlok_app/pages/home.dart';
import 'package:marlok_app/pages/matches.dart';
import 'package:marlok_app/pages/profile.dart';
import 'package:marlok_app/pages/rooms.dart';
class CupertinoNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.conversation_bubble),
                title: Text('Rooms'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.paw),
                title: Text('Matches'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                title: Text('Profile'),
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            assert(index >= 0 && index <= 3);
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (BuildContext context) => HomePage(),
                  defaultTitle: 'Home',
                );
                break;
              case 1:
                return CupertinoTabView(
                  builder: (BuildContext context) => RoomPage(),
                  defaultTitle: 'Rooms',
                );
                break;
              case 2:
                return CupertinoTabView(
                  builder: (BuildContext context) => MatchesPage(),
                  defaultTitle: 'Matches',
                );
                break;
              case 3:
                return CupertinoTabView(
                  builder: (BuildContext context) => ProfilePage(),
                  defaultTitle: 'Account',
                );
                break;
            }
            return null;
          },
        ),
      );
  }
}


    
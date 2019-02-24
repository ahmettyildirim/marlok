import 'package:flutter/material.dart';
import 'package:marlok_app/pages/home.dart';
import 'package:marlok_app/pages/matches.dart';
import 'package:marlok_app/pages/profile.dart';
import 'package:marlok_app/pages/rooms.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Widget target,
    TickerProvider vsync,
  }) : _icon = icon,
       _title = title,
       _target=target,
       item = BottomNavigationBarItem(
         icon: icon,
         activeIcon: activeIcon,
         title: Text(title, style: TextStyle(color: Colors.red),),
         backgroundColor: Colors.white,

       ),
       controller = AnimationController(
         duration: kThemeAnimationDuration,
         vsync: vsync,
       ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final Widget _target;
  final Widget _icon;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = Colors.red;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}


class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      decoration: BoxDecoration(
        border: Border.all(color: iconTheme.color, width: 2.0),
      )
    );
  }
}


class MaterialNavigation extends StatefulWidget {
  _MaterialNavigationState createState() => _MaterialNavigationState();
}

class _MaterialNavigationState extends State<MaterialNavigation>  with TickerProviderStateMixin{
  
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;
    @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: const Icon(Icons.home, color: Colors.black,),
        activeIcon: const Icon(Icons.home, color: Colors.red,),
        title: 'Home',
        vsync: this,
        target: HomePage()
      ),
      NavigationIconView(
        icon: const Icon(Icons.chat,color: Colors.black,),
        activeIcon: const Icon(Icons.chat_bubble, color: Colors.red,),
        title: 'Rooms',
        vsync: this,
        target: RoomPage()
      ),
      NavigationIconView(
        icon: const Icon(Icons.collections,color: Colors.black,),
        activeIcon: const Icon(Icons.collections, color: Colors.red,),
        title: 'Matches',
        vsync: this,
        target: MatchesPage()
      ),
      NavigationIconView(
        icon: const Icon(Icons.account_circle,color: Colors.grey,),
        activeIcon: const Icon(Icons.account_circle, color: Colors.red,),
        title: 'Profile',
        vsync: this,
        target: HomePage()
      )
    ];

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      //iconSize: 4.0,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
          print(_currentIndex);
        });
      },
    );
    return 
    Scaffold(
      bottomNavigationBar: botNavBar,
      body: _navigationViews[_currentIndex]._target
    );
  }
}
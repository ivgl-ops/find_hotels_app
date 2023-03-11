import 'package:find_hotels_app/view/main_view.dart';
import 'package:flutter/material.dart';

import 'favorite_hotels_view.dart';

  class StartView extends StatefulWidget {
    final int index;

    StartView({super.key,  required this.index});

    @override
    State<StartView> createState() => StartViewState();
  }

  class StartViewState extends State<StartView> {
    int _selectedIndex = 0;
    static const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    static const List<Widget> _widgetOptions = <Widget>[
      MainView(),
      FavoriteHotelsView(),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
      Text(
        'Index 3: Settings',
        style: optionStyle,
      ),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
    @override
    void initState() {
      super.initState();
      _selectedIndex = widget.index;
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff007AFF),
        unselectedItemColor: Color(0xffCCCCCC),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_none_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

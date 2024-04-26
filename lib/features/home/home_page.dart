import 'package:energise_test/l10n/app_loc.dart';
import 'package:flutter/material.dart';

import '../timer/timer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List <Widget> _pages = [
    const TimerPage(),
    Container(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(
            icon: const Icon(Icons.timer),
            label: context.loc.timer,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.location_on),
            label: context.loc.location,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: context.loc.settings,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

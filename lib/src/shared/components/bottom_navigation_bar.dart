import 'package:flutter/material.dart';

class LazuliBottomNavigationBar extends StatefulWidget {
  const LazuliBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LazuliBottomNavigationBarState();
}

class _LazuliBottomNavigationBarState extends State<LazuliBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<NavigationDestination> destinations = const [
    NavigationDestination(
      label: 'Home',
      icon: Icon(Icons.home),
    ),
    NavigationDestination(
      label: 'Products',
      icon: Icon(Icons.store),
    ),
    NavigationDestination(
      label: 'Orders',
      icon: Icon(Icons.receipt_long),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        destinations: destinations,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped);
  }
}

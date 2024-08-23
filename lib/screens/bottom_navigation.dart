import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'lead_screen/follow_up/list_follow_up.dart';
import 'lead_screen/list_lead_screen.dart/list_lead_screen.dart';
import 'profile/profile_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {

  int _selectedIndex = 0;
  final List<Widget> screens = [
    const LeadListScreen(),
    const FollowUpListScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            elevation: 1,
            indicatorColor: Colors.blue.shade400,
            labelTextStyle: WidgetStateProperty.all(
              const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          child: NavigationBar(
            height: 60,
            
            backgroundColor: Colors.white,
         indicatorColor: Colors.blue,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              _onItemTapped(index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(CupertinoIcons.person_2_fill),
                label: 'Leads',
                selectedIcon: Icon(CupertinoIcons.person_2_fill),
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.calendar_badge_plus),
                label: 'Follow Up',
                selectedIcon: Icon(CupertinoIcons.calendar_badge_plus),
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.profile_circled),
                label: 'Account',
                selectedIcon: Icon(CupertinoIcons.profile_circled),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

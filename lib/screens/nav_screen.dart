import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:web/screens/home_screen.dart';
import 'package:web/widgets/widgets.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}


class _NavScreenState  extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    Scaffold(),
   // Scaffold(),

  ];
  final List<IconData> _icons = const [
    Icons.home,
    MdiIcons.accountCircleOutline,
   // Icons.settings,

  ];
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
        child: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: CustomTabBar(
            icons : _icons,
            selectedIndex : _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        ));
  }


}

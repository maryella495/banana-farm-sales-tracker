// root_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/pages/add_sale_page.dart';
import 'package:myapp/pages/analytics_page.dart';
import 'package:myapp/pages/archive_page.dart';
import 'package:myapp/pages/dashboard_page.dart';
import 'package:myapp/pages/settings_page.dart';

final GlobalKey<RootPageState> rootPageKey = GlobalKey<RootPageState>();

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  static void navigateTo(int index) {
    rootPageKey.currentState?._setIndex(index);
  }

  @override
  State<RootPage> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    AnalyticsPage(),
    SizedBox.shrink(), // placeholder for Add button
    ArchivePage(),
    SettingsPage(),
  ];

  void _setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddSalePage()),
            );
          } else {
            setState(() => _currentIndex = index);
          }
        },
        selectedItemColor: const Color(0xFF0A6305),
        unselectedItemColor: Colors.black54,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Analytics",
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: const Offset(0, 4),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0A6305),
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(Icons.add, color: Colors.white, size: 24),
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/archive.svg',
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? const Color(0xFF0A6305) : Colors.black54,
                BlendMode.srcIn,
              ),
            ),
            label: "Archive",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

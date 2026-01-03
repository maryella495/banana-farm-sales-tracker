import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/pages/dashboard_page.dart';
import 'package:myapp/pages/analytics_page.dart';
import 'package:myapp/pages/archive_page.dart';
import 'package:myapp/pages/settings_page.dart';
import 'package:myapp/pages/add_sale_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    AnalyticsPage(),
    ArchivePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex < 2 ? _currentIndex : _currentIndex + 1,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddSalePage()),
            );
          } else {
            setState(() => _currentIndex = index > 2 ? index - 1 : index);
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
                _currentIndex == 2 ? const Color(0xFF0A6305) : Colors.black54,
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

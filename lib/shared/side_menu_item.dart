import 'package:flutter/material.dart';

class SideMenuItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  SideMenuItem({required this.label, required this.icon, required this.onTap});
}

class SideMenu extends StatelessWidget {
  final String title;
  final List<SideMenuItem> items;

  const SideMenu({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header with back button
          Container(
            color: const Color(0xFF0A6305),
            padding: const EdgeInsets.only(
              top: 40,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),

          // Menu items
          Expanded(
            child: ListView(
              children: items
                  .map(
                    (item) => Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Icon(
                          item.icon,
                          color: const Color(0xFF0A6305),
                        ),
                        title: Text(
                          item.label,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          item.onTap();
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

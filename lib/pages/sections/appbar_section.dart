import 'package:flutter/material.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leadingIcon;
  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  const appBar({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subtitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        crossAxisAlignment: subtitle == null
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          leadingIcon,
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: subtitle == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A6305),
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ],
          ),
        ],
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF0A6305)),
            onPressed: () {
              Scaffold.of(context).openEndDrawer(); // now works
            },
          ),
        ),
      ],

      toolbarHeight: 80,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

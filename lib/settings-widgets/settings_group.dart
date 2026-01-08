import 'package:flutter/material.dart';
import 'settings_item.dart';

class SettingsGroup extends StatelessWidget {
  final List<SettingsItem> items;

  const SettingsGroup({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            items[i],
            if (i < items.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}

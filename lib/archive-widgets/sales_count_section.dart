import 'package:flutter/material.dart';

class SalesCountSection extends StatelessWidget {
  final int count;
  final VoidCallback onFilterTap;

  const SalesCountSection({
    super.key,
    required this.count,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$count sale${count == 1 ? '' : 's'} found",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF0A6305)),
            tooltip: "Filter by variety or date",
            onPressed: onFilterTap,
          ),
        ],
      ),
    );
  }
}

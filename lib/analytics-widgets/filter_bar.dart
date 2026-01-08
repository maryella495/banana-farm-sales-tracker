import 'package:flutter/material.dart';
import 'package:myapp/shared/ui_helpers.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:myapp/providers/sales_provider.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();
    final range = provider.filterRange;

    String label;
    if (range == null) {
      label = "Showing: All Time";
    } else {
      final start = DateFormat("MMM d").format(range.start);
      final end = DateFormat("MMM d").format(range.end);
      label = "Showing: $start – $end";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Expanded filter buttons row
        Row(
          children: [
            Expanded(
              child: _FilterButton(
                label: "This Week",
                onTap: () => provider.filterThisWeek(),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _FilterButton(
                label: "This Month",
                onTap: () => provider.filterThisMonth(),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _FilterButton(
                label: "All Time",
                onTap: () => provider.clearFilter(),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _FilterButton(
                label: "Custom",
                onTap: () async {
                  final picked = await showGreenDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    provider.setFilterRange(picked);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Active filter indicator chip
        Chip(
          avatar: Icon(
            Icons.filter_alt,
            color: Colors.black.withValues(alpha: 0.7),
            size: 18,
          ),
          label: Text(
            "Showing: $label",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black.withValues(alpha: 0.7),
            ),
          ),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(color: Colors.black.withValues(alpha: 0.3)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          deleteIcon: Icon(
            Icons.close,
            color: Colors.black.withValues(alpha: 0.7),
            size: 18,
          ),
          onDeleted: () => provider.clearFilter(),
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FilterButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return Color(0xFFE8F5E9);
          }
          if (states.contains(WidgetState.pressed)) {
            return Colors.black.withValues(alpha: 0.1);
          }
          return Colors.transparent;
        }),
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          if (states.contains(WidgetState.hovered)) return 4;
          if (states.contains(WidgetState.pressed)) return 2;
          return 0; // flat by default
        }),
        shadowColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return Colors.black.withValues(alpha: 0.3);
          }
          return Colors.transparent;
        }),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(color: Colors.black.withValues(alpha: 0.3)),
          ),
        ),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.black.withValues(alpha: 0.7),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/dashboard-widgets/revenue_section.dart';

/// DashboardHeader
/// ---------------
/// Displays the top section of the DashboardPage.
///
/// Purpose:
/// - Shows app branding and quick summary metrics.

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // allow overlap
      children: [
        // Green background rectangle
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 220, // taller so it flows into RevenueSection
            decoration: BoxDecoration(
              color: const Color(0xFF0A6305),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
        ),

        // Transparent greeting container
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 15, color: Colors.black87),
              children: [
                const TextSpan(
                  text: "Welcome back, Farmer! 🍌\n",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const TextSpan(
                  text: "\nThis is your ",
                  style: TextStyle(color: Colors.white),
                ),
                const TextSpan(
                  text: "Banana Farm Sales Tracker",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const TextSpan(
                  text: " — monitor sales and grow your business.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),

        // RevenueSection overlapping into green background
        Positioned(
          bottom: -100,
          left: 0,
          right: 0,
          child: const RevenueSection(),
        ),
      ],
    );
  }
}

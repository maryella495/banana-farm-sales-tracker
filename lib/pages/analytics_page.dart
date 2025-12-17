import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weeklySales = {
      "Mon": 1000,
      "Tue": 2500,
      "Wed": 1800,
      "Thu": 3000,
      "Fri": 2000,
      "Sat": 500,
      "Sun": 0,
    };

    return Scaffold(
      appBar: AppBar(title: const Text("Analytics")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            "Weekly Sales",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Bar chart with background grid
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: weeklySales.entries.map((entry) {
                final height = (entry.value / 5000) * 150;
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        height: height,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Color(0xFF0A6305),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 32),

          // Summary stats styled as cards
          summaryCard(
            icon: Icons.scale,
            label: "Average Price per Kilo",
            value: "₱45",
          ),
          summaryCard(
            icon: Icons.trending_up,
            label: "Highest Sale",
            value: "₱2,000 on Dec 10",
          ),
          summaryCard(
            icon: Icons.trending_down,
            label: "Lowest Sale",
            value: "₱200 on Dec 10",
          ),
        ],
      ),
    );
  }

  Widget summaryCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF0A6305)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

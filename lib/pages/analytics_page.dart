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
      appBar: AppBar(
        title: const Text(
          "Analytics",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart, color: Color(0xFF0A6305)),
              SizedBox(width: 8),
              Text(
                "Weekly Sales",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bar chart with background grid
          Container(
            height: 220,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [6000, 4500, 3000, 1500, 0].map((value) {
                    return SizedBox(
                      height: 150 / 4,
                      child: Text(
                        "₱${(value / 1000).toStringAsFixed(1)}k",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 8),

                // Chart bars
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            // Grid lines
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(5, (_) {
                                return Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                );
                              }),
                            ),
                            // Bars
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: weeklySales.entries.map((entry) {
                                  final height = (entry.value / 6000) * 150;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 600,
                                        ),
                                        height: height,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF0A6305),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
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
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Summary stats styled as cards
          simpleSummaryCard(label: "Average Price per Kilo", value: "₱45"),
          detailedSummaryCard(
            icon: Icons.trending_up,
            label: "Highest Sale",
            name: "Pedro Garcia",
            date: "Dec 10",
            value: "₱2,000",
            valueColor: Color(0xFF0A6305),
            iconColor: Color(0xFF0A6305),
          ),
          detailedSummaryCard(
            icon: Icons.trending_down,
            label: "Lowest Sale",
            name: "Ana Reyes",
            date: "Dec 12",
            value: "₱200",
            valueColor: Color(0xFFE6A10C),
            iconColor: Color(0xFFE6A10C),
          ),
        ],
      ),
    );
  }

  Widget simpleSummaryCard({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailedSummaryCard({
    required IconData icon,
    required String label,
    required String name,
    required String date,
    required String value,
    Color valueColor = Colors.black,
    Color iconColor = const Color(0xFF0A6305),
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: iconColor),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/pages/sales_details_page.dart';

class RecentTransactionSection extends StatelessWidget {
  const RecentTransactionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {
        "name": "Maria Cruz",
        "date": "Dec 15, 2025",
        "amount": "₱200",
        "quantity": "50",
        "pricePerKg": "45",
        "notes": "Regular customer",
      },
      {
        "name": "Juan Santos",
        "date": "Dec 15, 2025",
        "amount": "₱2,000",
        "quantity": "100",
        "pricePerKg": "20",
        "notes": "",
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "RECENT TRANSACTIONS",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...transactions.map(
            (tx) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SaleDetailsPage(
                        name: tx["name"]!,
                        date: tx["date"]!,
                        amount: tx["amount"]!,
                        quantity: tx["quantity"]!,
                        pricePerKg: tx["pricePerKg"]!,
                        notes: tx["notes"]!,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFFBCDABB),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFF0A6305),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tx["name"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tx["date"]!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        tx["amount"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF0A6305),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

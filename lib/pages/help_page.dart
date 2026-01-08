import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            "Help & Support",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            "Need assistance? Browse the FAQs below or contact our team.",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 20),

          // FAQ Section
          ExpansionTile(
            leading: const Icon(
              Icons.question_answer,
              color: Color(0xFF0A6305),
            ),
            title: const Text("How do I add a new sale?"),
            children: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Go to the Sales page and tap the '+' button. Fill in the buyer, "
                  "variety, quantity, and price, then save.",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(
              Icons.question_answer,
              color: Color(0xFF0A6305),
            ),
            title: const Text("Can I import sales from a CSV file?"),
            children: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Yes. On the Dashboard, tap the upload icon and select your CSV file. "
                  "Your sales will be imported automatically.",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(
              Icons.question_answer,
              color: Color(0xFF0A6305),
            ),
            title: const Text("Where is my data stored?"),
            children: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "All data is stored securely on your device. Future updates may "
                  "include optional cloud backup, but you will always control "
                  "whether to enable it.",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Text(
            "For further support, contact us at support@bananatrack.com",
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

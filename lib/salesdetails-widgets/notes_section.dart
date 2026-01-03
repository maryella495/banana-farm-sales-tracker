import 'package:flutter/material.dart';

class NotesSection extends StatelessWidget {
  final String notes;
  const NotesSection({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description, color: Color(0xFF0A6305), size: 22),
              const SizedBox(width: 4),
              const Text(
                "Notes",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            notes.isNotEmpty ? notes : "—",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

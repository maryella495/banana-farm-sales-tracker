import 'package:flutter/material.dart';
import 'package:myapp/salesdetails-widgets/edit-sale-section/edit_sale_helpers.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDatePicked;
  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDatePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.calendar_today, size: 18, color: Color(0xFF0A6305)),
            SizedBox(width: 6),
            Text(
              "Date of Sale *",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: _boxDecoration,
          child: TextFormField(
            key: ValueKey(selectedDate), // forces rebuild when date changes
            readOnly: true,
            initialValue: selectedDate != null
                ? "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}"
                : "",
            decoration: _inputDecoration("Select Date"),
            validator: (_) => selectedDate == null ? "Required" : null,
            onTap: () async {
              final now = DateTime.now();
              final picked = await showGreenDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: now,
              );
              if (picked != null) {
                onDatePicked(picked);
              }
            },
          ),
        ),
      ],
    );
  }
}

final _boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: Colors.grey.shade300),
);

InputDecoration _inputDecoration(String hint) => InputDecoration(
  hintText: hint,
  border: InputBorder.none,
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
);

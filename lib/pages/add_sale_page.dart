import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:myapp/addsale-widgets/add_sale_footer_buttons.dart';
import 'package:myapp/addsale-widgets/buyer_name_field_section.dart';
import 'package:myapp/addsale-widgets/date_picker_field.dart';
import 'package:myapp/addsale-widgets/notes_field.dart';
import 'package:myapp/addsale-widgets/price_field.dart';
import 'package:myapp/addsale-widgets/quantity_field.dart';
import 'package:myapp/addsale-widgets/variation_field.dart';
import 'package:myapp/models/sale.dart';
import 'package:myapp/providers/sales_provider.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({super.key});

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _buyerController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String? _selectedVariation;
  String? _customVariation;

  // Only banana variations
  final List<String> _variations = ["Lakatan", "Latundan", "Cardava", "Other"];

  void _saveSale() async {
    if (_quantityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a quantity"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    if (quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Quantity must be greater than 0"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedVariation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a variety"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedVariation == "Other" &&
        (_customVariation?.trim().isEmpty ?? true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a custom variety"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final price = double.tryParse(_priceController.text) ?? 0.0;

      final sale = Sale(
        id: null,
        variety: _selectedVariation == "Other"
            ? (_customVariation?.trim().isNotEmpty == true
                  ? _customVariation!.trim()
                  : "Unknown")
            : (_selectedVariation?.trim().isNotEmpty == true
                  ? _selectedVariation!.trim()
                  : "Unknown"),
        quantity: quantity,
        price: price,
        buyer: _buyerController.text.trim().isEmpty
            ? "Unknown Buyer"
            : _buyerController.text.trim(),
        date: _selectedDate,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );
      final salesProvider = context.read<SalesProvider>();
      final notifier = context.read<NotificationProvider>();

      debugPrint("Saving sale: ${sale.toMap()}");

      final provider = context.read<SalesProvider>();

      // Duplicate check before saving
      if (provider.isDuplicate(sale)) {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              "Possible Duplicate",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "A sale with the same details already exists. Do you still want to save it?",
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey.shade700,
                ),
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A6305),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Save Anyway"),
              ),
            ],
          ),
        );

        if (confirm != true) return; // user cancelled
      }

      // Proceed with saving
      final newSale = await provider.addSale(sale);

      if (!mounted) return;

      if (newSale != null) {
        notifier.addNotification(
          "Sale added: ${newSale.buyer} | ${newSale.variety} | "
          "${newSale.quantity}kg @ ₱${newSale.price} "
          "(${DateFormat('MMM d, yyyy').format(newSale.date)})",
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Sale added successfully",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFF0A6305),
          ),
        );
        _buyerController.clear();
        _priceController.clear();
        _notesController.clear();
        _quantityController.clear();
        setState(() {
          _selectedVariation = null;
          _customVariation = null;
          _selectedDate = DateTime.now();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Failed to add sale",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _buyerController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F5E9),
        title: const Text(
          "Add New Sale",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              BuyerNameField(controller: _buyerController),
              const SizedBox(height: 16),

              DatePickerField(
                selectedDate: _selectedDate,
                onDatePicked: (picked) {
                  if (picked != null) {
                    setState(() => _selectedDate = picked);
                  }
                },
              ),
              const SizedBox(height: 16),

              VariationField(
                selectedVariation: _selectedVariation,
                customVariation: _customVariation,
                variations: _variations,
                onChanged: (value) =>
                    setState(() => _selectedVariation = value),
                onCustomChanged: (val) =>
                    setState(() => _customVariation = val),
              ),
              const SizedBox(height: 16),

              QuantityField(controller: _quantityController),

              const SizedBox(height: 16),

              PriceField(
                controller: _priceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a price";
                  }
                  if (double.tryParse(value) == null) {
                    return "Enter a valid number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              NotesField(controller: _notesController),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AddSaleFooterButtons(
        onCancel: () => Navigator.pop(context),
        onSave: _saveSale,
      ),
    );
  }
}

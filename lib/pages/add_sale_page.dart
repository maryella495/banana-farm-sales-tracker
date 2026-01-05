import 'package:flutter/material.dart';
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

  final _buyerController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String? _selectedVariation;
  String? _customVariation;

  // Only banana variations
  final List<String> _variations = ["Lakatan", "Latundan", "Cardava", "Other"];

  int _quantity = 1;

  void _saveSale() {
    if (_formKey.currentState!.validate()) {
      final sale = Sale(
        id: DateTime.now().millisecondsSinceEpoch,
        variety: _selectedVariation ?? _customVariation ?? "Unknown",
        quantity: _quantity,
        price: double.parse(_priceController.text),
        buyer: _buyerController.text,
        date: _selectedDate,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );

      context.read<SalesProvider>().addSale(sale);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Sale added successfully",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF0A6305),
        ),
      );

      // Reset form fields
      _buyerController.clear();
      _priceController.clear();
      _notesController.clear();
      setState(() {
        _quantity = 1;
        _selectedVariation = null;
        _customVariation = null;
        _selectedDate = DateTime.now();
      });
    }
  }

  @override
  void dispose() {
    _buyerController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

              QuantityField(
                quantity: _quantity,
                onIncrement: () => setState(() => _quantity++),
                onDecrement: () => setState(() {
                  if (_quantity > 0) _quantity--;
                }),
              ),
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

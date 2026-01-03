import 'package:flutter/material.dart';
import 'package:myapp/addsale-widgets/add_sale_footer_buttons.dart';
import 'package:myapp/addsale-widgets/buyer_name_field_section.dart';
import 'package:myapp/addsale-widgets/date_picker_field.dart';
import 'package:myapp/addsale-widgets/notes_field.dart';
import 'package:myapp/addsale-widgets/price_field.dart';
import 'package:myapp/addsale-widgets/quantity_field.dart';
import 'package:myapp/addsale-widgets/variation_field.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({super.key});

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _buyerController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  // State
  DateTime? _selectedDate;
  String? _selectedVariation;
  String? _customVariation;
  int _quantity = 0;

  final List<String> _variations = ["Latundan", "Lakatan", "Cardava"];

  void _saveSale() {
    if (_formKey.currentState!.validate() && _quantity > 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Sale saved successfully!")));
      Navigator.pop(context);
    } else if (_quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Quantity must be greater than 0")),
      );
    }
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
                onDatePicked: (picked) =>
                    setState(() => _selectedDate = picked),
              ),
              const SizedBox(height: 16),

              VariationField(
                selectedVariation: _selectedVariation,
                customVariation: _customVariation,
                variations: _variations,
                onChanged: (value) =>
                    setState(() => _selectedVariation = value),
                onCustomChanged: (val) => _customVariation = val,
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

              PriceField(controller: _priceController),
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

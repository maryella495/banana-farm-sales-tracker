import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  final VoidCallback onSignOut;
  const SignOutButton({super.key, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onSignOut,
      icon: const Icon(Icons.logout, color: Colors.red),
      label: const Text("Sign Out", style: TextStyle(color: Colors.red)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}

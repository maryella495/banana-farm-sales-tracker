import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/pages/root_page.dart';
import 'package:myapp/providers/sales_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SalesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootPage(key: rootPageKey),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:myapp/pages/root_page.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize DB
  await DatabaseService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SalesProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
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

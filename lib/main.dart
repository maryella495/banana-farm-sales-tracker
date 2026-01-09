import 'package:flutter/material.dart';
import 'package:myapp/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:myapp/pages/root_page.dart';
import 'package:myapp/providers/sales_provider.dart';
import 'package:myapp/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseService().init();
  final salesProvider = SalesProvider();
  await salesProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: salesProvider),
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

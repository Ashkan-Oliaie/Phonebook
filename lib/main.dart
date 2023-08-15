import 'package:flutter/material.dart';
import 'package:phonebook/core/router.dart';
import 'core/setup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Phonebook',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: Routes.contactList,
        onGenerateRoute: CustomRouter.generateRoutes);
  }
}

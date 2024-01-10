import 'package:flutter/material.dart';
import 'package:party/appState.dart';
import 'package:party/scanFound.dart';
import 'package:party/scanner.dart';
import 'package:party/welcome.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scan App',
      initialRoute: '/',
      routes: {
        '/': (context) => welcome(),
        '/scanner': (context) => Scanner(),
        '/scanFound': (context) => ScanFound(),
      },
    );
  }

  Widget welcome() {
    return const Welcome();
  }

  Widget scanner() {
    return Scanner();
  }

  Widget scanFound() {
    return ScanFound();
  }
}
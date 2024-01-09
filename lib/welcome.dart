import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Scan QR'),
          onPressed: () {
            Navigator.pushNamed(context, '/scanner');
          },
        ),
      ),
    );
  }
}
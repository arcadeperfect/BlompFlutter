import 'package:flutter/material.dart';
import 'package:party/tcpip.dart';

class ScanFound extends StatelessWidget {
  ScanFound({super.key});

  final tcp = TcpClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[ 
          Center(child: ElevatedButton(onPressed: onPressedConnect, child: const Text('TestConnect'),)),
          Center(child: ElevatedButton(onPressed: onPressedSend, child: const Text('TestSend'),)),]
      ),
    );
  }

  void onPressedConnect(){
    print(hashCode);
    tcp.connect('192.168.1.163',8000);
  }
    void onPressedSend(){
    tcp.sendMessage('Hello, World!');
    tcp.disconnect();
  }
}
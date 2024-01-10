import 'dart:io';

import 'package:flutter/material.dart';
import 'package:osc/osc.dart';
import 'package:party/appState.dart';
import 'package:provider/provider.dart';

class SendOSC extends StatefulWidget {
  const SendOSC({Key? key}) : super(key: key);

  @override
  _SendOSCState createState() => _SendOSCState();
}

class _SendOSCState extends State<SendOSC> {
  late OSCSender oscSender;

  @override
  Widget build(BuildContext context) {
    final MyAppState appState = Provider.of<MyAppState>(context, listen: false);
    // if(appState.serverAddress == null || appState.uniquePort == null) {
    //   return;
    // }
    oscSender = OSCSender(
        appState.serverAddress as InternetAddress, appState.uniquePort as int);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Send OSC'),
          onPressed: () {
            oscSender.SendFloat(0.5, '/test');
          },
        ),
      ),
    );
  }
}

class OSCSender {
  final InternetAddress ipAddress;
  final int port;
  late InternetAddress destination;

  OSCSender(this.ipAddress, this.port) {
    destination = InternetAddress(ipAddress.address);
  }

  void SendFloat(double value, String oscAddress) async {
    var message = OSCMessage(oscAddress, arguments: [value]);
    var oscSocket = OSCSocket(
      destination: InternetAddress(ipAddress.address),
      destinationPort: port,
    );

    print('sending $message to $destination:$port');

    await oscSocket.setupSocket();
    await oscSocket.send(message);
    oscSocket.close();

    print('sent $message to $destination:$port');
  }
}

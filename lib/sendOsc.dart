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
  double sliderValue = 0.5; // Initial value for the slider

  @override
  Widget build(BuildContext context) {
    final MyAppState appState = Provider.of<MyAppState>(context, listen: false);
    oscSender = OSCSender(
        appState.serverAddress as InternetAddress, appState.uniquePort as int);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Slider(
              min: 0,
              max: 1,
              value: sliderValue, // Use the state variable here
              onChanged: (double value) {
                setState(() {
                  sliderValue = value; // Update the state variable
                });
                oscSender.SendFloat(value, '/size'); // Send OSC message
              },
            ),
            ElevatedButton(
              child: const Text('Blomp'),
              onPressed: () {
                oscSender.SendPress('/jump');
              },
            ),
          ],
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

  void SendPress(String oscAddress) async {
    var message = OSCMessage(oscAddress, arguments: []);
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

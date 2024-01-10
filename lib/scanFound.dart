import 'package:flutter/material.dart';
import 'package:party/tcpip.dart';
import 'package:provider/provider.dart';
import 'package:party/appState.dart';
import 'package:uuid/uuid.dart';

class ScanFound extends StatelessWidget {
  ScanFound({super.key});

  final tcp = TcpClient();

  @override
  Widget build(BuildContext context) {
    print("ScanFound build");
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
            child: ElevatedButton(
              onPressed: () => onPressedConnect(context),
          child: const Text('TestConnect'),
        )),
        // Center(child: ElevatedButton(onPressed: onPressedSend, child: const Text('TestSend'),)),]
      ]),
    );
  }

  void onPressedConnect(BuildContext context) async {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    String? serverAddress = appState.serverAddress;
    int? handShakePort = appState.handShakePort;

    if (serverAddress == null || handShakePort == null) {
      print('serverAddress or handShakePort is null');
      return;
    }

    await tcp.connect(serverAddress as String, handShakePort as int);
    
    print('server address is $serverAddress'    'handShakePort is $handShakePort');

    tcp.sendMessage(randomId());
    tcp.setOnDataReceivedCallback(
      (String response) {
        int? newPort = int.tryParse(response) ?? null;
        
        newPort == null
            ? print('newPort is null')
            :appState.setUniquePort(newPort);
        
        if(newPort == null) {
          print('newPort is null');
        }
        else {
          appState.setUniquePort(newPort as int);
          tcp.disconnect();
          print(appState.uniquePort);
        }
      },
    );
  }

  String randomId() {
    var uuid = Uuid();
    return uuid.v4();
  }
}

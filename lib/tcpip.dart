import 'dart:io';
import 'dart:async';
// import 'package:uuid/uuid.dart';

class TcpClient {
  late Socket _socket;
  Function(String)? onDataReceived;

  void setOnDataReceivedCallback(Function(String) callback) {
    onDataReceived = callback;
  }

  Future<void> connect(String host, int port) async {
    _socket = await Socket.connect(host, port);
    print('Connected to: ${_socket.remoteAddress.address}:${_socket.remotePort}');

    _socket.listen(
      (data) {
        final serverResponse = String.fromCharCodes(data);
        print('Server: $serverResponse');
        onDataReceived?.call(serverResponse); 
      },

      onError: (error) {
        print('Error: $error');
        _socket.destroy();
      },

      onDone: () {
        print('Server left.');
        _socket.destroy();
      },
    );
  }

  // Send message to the server
  void sendMessage(String message) {
    print('Client: $message');
    _socket.write(message);
  }

  // Close the connection
  void disconnect() {
    _socket.close();
  }
}

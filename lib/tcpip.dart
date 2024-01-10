import 'dart:io';
import 'dart:async';
import 'package:uuid/uuid.dart';


class TcpClient {
  late Socket _socket;

  // Connect to the server
  Future<void> connect(String host, int port) async {
    _socket = await Socket.connect(host, port);
    print('Connected to: ${_socket.remoteAddress.address}:${_socket.remotePort}');

    // Listen for responses from the server
    _socket.listen(
      // Handle data from the server
      (data) {
        final serverResponse = String.fromCharCodes(data);
        print('Server: $serverResponse');
      },

      // Handle errors
      onError: (error) {
        print('Error: $error');
        _socket.destroy();
      },

      // Handle server ending connection
      onDone: () {
        print('Server left.');
        _socket.destroy();
      },
    );

    String randomId(){
      var uuid = Uuid();
      return uuid.v4();
    }
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
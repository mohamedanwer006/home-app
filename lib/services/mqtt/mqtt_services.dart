import 'dart:io';
import 'dart:convert';
// import 'package:mqtt_client/mqtt_browser_client.dart'; //comment for android
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
// import 'package:flutter/foundation.dart' show kIsWeb; //comment for android

const bool kIsWeb = false ; //uncomment for android

class MqttServices {
  ///use in run for web
  static const String webHost = 'wss://m16.cloudmqtt.com';
  static const String host = 'm16.cloudmqtt.com';
  static const String username = 'zwccckwo';
  static const String password = 'lm8yAHH_5KWj';
  static const String clientId = 'AndroidApp';
  static const String webClientId = 'WebApp';
  static const int webPort = 31638;
  static const int port = 11638;
  static const int keepalive = 30;

  final client;

//uncomment for android
  MqttServices._()
      : client =  MqttServerClient.withPort(host, clientId, port);

///uncomment for web
// MqttServices._()
//       : client = kIsWeb
//             ? MqttBrowserClient.withPort(webHost, webClientId, webPort)
//             : MqttServerClient.withPort(host, clientId, port);


  static final MqttServices _singleton = MqttServices._();

  factory MqttServices() {
    return _singleton;
  }

  void initClient() async {
    client.keepAlivePeriod = keepalive;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;

    final connMess = MqttConnectMessage()
        .withClientIdentifier(kIsWeb ? webClientId : clientId)
        .keepAliveFor(30) // Must agree with the keep alive set above or not set
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect(username, password);
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }

    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    exit(-1);
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  void toggleDevice(String deviceId, String value) {
    print('device:$deviceId :$value ');
    final builder = MqttClientPayloadBuilder();
    builder.addString(json.encode({"value": "$value"}));
    client.publishMessage(
        'devices/$deviceId', MqttQos.exactlyOnce, builder.payload);
  }
}

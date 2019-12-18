import 'dart:async';

import 'package:flutter/services.dart';

class SystemProxy {
  static const MethodChannel _channel = const MethodChannel('mobile_system_proxy');

  static Future<Proxy> getSystemProxy() async {
    var result = await _channel.invokeMethod('getProxy') as List;
    if (result != null) {
      return Proxy(
        host: result[0],
        port: result[1],
      );
    }
    return null;
  }
}

class Proxy {
  final String host;
  final int port;

  const Proxy({
    this.host,
    this.port,
  });

  String get formatted => '$host:$port';
}

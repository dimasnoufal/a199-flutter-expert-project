import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class SSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await createLEClient();

  static http.Client? _clientInstance;

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await createLEClient();
  }

  static Future<http.Client> createLEClient() async {
    final context = await globalContext;
    final client = HttpClient(context: context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return IOClient(client);
  }

  static Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificates/certificates.pem');
    final securityContext = SecurityContext(withTrustedRoots: true);
    securityContext.setTrustedCertificatesBytes(
      sslCert.buffer.asUint8List(sslCert.offsetInBytes, sslCert.lengthInBytes),
    );
    return securityContext;
  }
}

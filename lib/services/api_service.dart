import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class ApiService {

  static String get baseUrl {
    if (kIsWeb) {
      // web Chrome
      return "http://localhost:8000";
    } else {
      // Android Emulator
      return "http://10.0.2.2:8000";
    }
  }

  static Future<Map<String, dynamic>> analisarImagem(XFile image) async {

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/analisar'),
    );

    
    final bytes = await image.readAsBytes();

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: 'image.jpg',
      ),
    );

    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception("Erro na API: $responseData");
    }

    return jsonDecode(responseData);
  }
}
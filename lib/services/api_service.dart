import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<Map<String, dynamic>> analisarImagem(XFile image) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/analisar'),
    );

    request.headers['Accept'] = 'application/json';

    final bytes = await image.readAsBytes();

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: image.name,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final response = await request.send();

    final responseData =
        await response.stream.bytesToString();

    print("STATUS: ${response.statusCode}");
    print("RESPOSTA: $responseData");

    if (response.statusCode != 200) {
      throw Exception(
        "Erro na API: ${response.statusCode} - $responseData",
      );
    }

    return jsonDecode(responseData);
  }
}
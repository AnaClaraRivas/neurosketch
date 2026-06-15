    import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiService {

  static const String baseUrl =
      "https://neurosketch-api.onrender.com";

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

    print(responseData);

    if (response.statusCode != 200) {
      throw Exception("Erro na API: $responseData");
    }

    return jsonDecode(responseData);
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Importante para definir o tipo do arquivo
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const String baseUrl = "https://neurosketch-api.onrender.com";

  static Future<Map<String, dynamic>> analisarImagem(XFile image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/analisar'),
    );

    // 1. Adiciona os headers para garantir boa comunicação com o CORS na Web
    request.headers.addAll({
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
    });

    final bytes = await image.readAsBytes();

    // 2. Adiciona o arquivo definindo explicitamente o tipo dele (contentType)
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: 'image.jpg',
        contentType: MediaType('image', 'jpeg'), // Evita que o navegador envie como binário genérico
      ),
    );

    // Envia a requisição
    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    print(responseData);

    if (response.statusCode != 200) {
      throw Exception("Erro na API: $responseData");
    }

    return jsonDecode(responseData);
  }
}

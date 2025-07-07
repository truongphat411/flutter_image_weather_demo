import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/models.dart';

class ImageRemoteDatasource {
  Future<List<ImageModel>> fetchImages() async {
    final response = await http.get(
      Uri.parse('https://mocki.io/v1/a5d4cf16-1f36-4f2b-b5cd-89772a83e999'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => ImageModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch images');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/models.dart';

class WeatherRemoteDatasource {
  Future<List<WeatherModel>> fetchWeather() async {
    final response = await http.get(
      Uri.parse('https://mocki.io/v1/b9607fd2-bd7a-484e-917f-a5e641ec6cc9'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => WeatherModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch weather');
    }
  }
}

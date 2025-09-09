import 'package:dio/dio.dart';
import 'package:doublevpartnersapp/config/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserController {
  static final _dio = Dio();
  static final String apiKey =
      dotenv.env['OPENAI_API_KEY'] ?? 'No se cargo el ApiKey';
  static const String model = 'gpt-5';

  static final headers = Options(
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
  );

  Future<List<String>> fetchUserData() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final temp = List<String>.from(
          data.map((country) => country['name']['common']),
        );

        temp.sort();

        return temp;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

  Future<List<String>> fetchDepartments(String country) async {
    try {
      final response = await _dio.post(
        openaiUrl,
        data: {
          'model': model,
          'input':
              'Give me 5 principal departments of $country like a list of string, be sure to include the department names only and the text returned is only a list exactly, no more text.',
        },
        options: headers,
      );

      if (response.statusCode == 200) {
        print("respuesta de openai: ${response.data}");

        final List<dynamic> data = response.data['choices'];
        return List<String>.from(data.map((item) => item['text']));
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      throw Exception('Error fetching departments: $e');
    }
  }

  Future<List<String>> fetchMunicipalities(String department) async {
    try {
      final response = await _dio.post(
        openaiUrl,
        data: {
          'model': model,
          'input':
              'Give me 5 principal municipalities of $department like a list of string, be sure to include the municipality names only and the text returned is only a list exactly, no more text.',
        },
        options: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['choices'];
        return List<String>.from(data.map((item) => item['text']));
      } else {
        throw Exception('Failed to load municipalities');
      }
    } catch (e) {
      throw Exception('Error fetching municipalities: $e');
    }
  }
}

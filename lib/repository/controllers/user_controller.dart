import 'package:dio/dio.dart';
import 'package:doublevpartnersapp/config/constants.dart';

class UserController {
  static final _dio = Dio();

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
      final response = await _dio.post(statesUrl, data: {'country': country});

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['states'];
        final departments = List<String>.from(data.map((item) => item['name']))
          ..sort();
        return departments;
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      throw Exception('Error fetching departments: $e');
    }
  }

  Future<List<String>> fetchMunicipalities(
    String country,
    String department,
  ) async {
    try {
      final response = await _dio.post(
        citiesUrl,
        data: {'country': country, 'state': department},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final municipalities = List<String>.from(data)..sort();
        return municipalities;
      } else {
        throw Exception('Failed to load municipalities');
      }
    } catch (e) {
      throw Exception('Error fetching municipalities: $e');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:doublevpartnersapp/config/constants.dart';

class UserController {
  final _dio = Dio();

  Future<List<String>> fetchUserData() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return List<String>.from(
          data.map((country) => country['name']['common']),
        );
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}

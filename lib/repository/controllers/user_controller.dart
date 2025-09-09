import 'package:dio/dio.dart';
import 'package:doublevpartnersapp/config/constants.dart';

class UserController {
  static final _dio = Dio();

  Future<Map<String, List<String>>> fetchCountries() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        final Map<String, List<String>> countries = {};
        for (final country in data) {
          final String name = country['name'];
          final List<dynamic> statesData = country['states'] ?? [];
          final states = List<String>.from(
            statesData.map((item) => item['name']),
          )..sort();
          countries[name] = states;
        }

        final sortedEntries = countries.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));
        return Map.fromEntries(sortedEntries);
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      throw Exception('Error fetching countries: $e');
    }
  }

  Future<List<String>> fetchMunicipalities(
    String country,
    String department,
  ) async {
    try {
      print('Fetching municipalities for $country, $department');

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
    } catch (e, st) {
      print('Error fetching municipalities: $e');
      print('Stack trace: $st');
      throw Exception('Error fetching municipalities: $e');
    }
  }
}

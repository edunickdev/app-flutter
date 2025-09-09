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

  Future<List<String>> fetchMunicipalitiesGet(
  String country,
  String department,
) async {
  try {
    final res = await _dio.get(
      citiesUrlQ,
      queryParameters: {
        "country": country.trim(),
        "state": department.trim(),
      },
    );

    if (res.statusCode == 200) {
      final body = res.data;

      // El endpoint /q a veces devuelve { data: [...] } y otras una lista directa.
      final dynamic data =
          (body is Map && body["data"] is List) ? body["data"] : body;

      if (data is List) {
        final list = data.map((e) => e.toString()).toList()..sort();
        return list;
      }
      throw Exception("Esquema inesperado en GET /q: ${body.runtimeType}");
    } else {
      throw Exception("HTTP ${res.statusCode}: ${res.statusMessage}");
    }
  } catch (e) {
    throw Exception('Error fetching municipalities (GET /q): $e');
  }
}
}

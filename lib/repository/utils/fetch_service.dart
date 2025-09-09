import 'package:dio/dio.dart';

final _dio = Dio();

Future<List<String>> getCountries() async {
  final response = await _dio.get(
    'https://restcountries.com/v3.1/all?fields=name',
  );

  if (response.statusCode == 200) {
    final obj = response.data;

    print("estos son los paises que estoy obteniendo: $obj");
    return List<String>.from(obj.map((country) => country['name']['common']));
  } else {
    throw Exception('Failed to load countries');
  }
}

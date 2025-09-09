import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClassName extends StateNotifier<AsyncValue<List<String>>> {
  ClassName() : super(const AsyncValue.loading());

  Future<void> fetchData() async {
    try {
      // Simula una llamada a un servicio que obtiene datos
      await Future.delayed(const Duration(seconds: 2));
      final data = ['Item 1', 'Item 2', 'Item 3']; // Reemplaza con datos reales
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

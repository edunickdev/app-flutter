import 'package:doublevpartnersapp/repository/controllers/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MunicipalityNotifier extends StateNotifier<AsyncValue<List<String>>> {
  MunicipalityNotifier() : super(const AsyncValue.data([]));

  final UserController _userController = UserController();

  Future<void> fetchMunicipalities(String country, String department) async {
    state = const AsyncValue.loading();
    try {
      final data =
          await _userController.fetchMunicipalities(country, department);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void clearData() {
    state = const AsyncValue.data([]);
  }
}
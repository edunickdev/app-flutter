import 'package:doublevpartnersapp/repository/controllers/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<AsyncValue<List<String>>> {
  UserNotifier() : super(const AsyncValue.loading());

  final UserController _userController = UserController();

  Future<void> fetchData() async {
    try {
      final data = await _userController.fetchUserData();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchDepartments(String country) async {
    try {
      final data = await _userController.fetchDepartments(country);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchMunicipalities(String department) async {
    try {
      final data = await _userController.fetchMunicipalities(department);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void clearData() {
    state = const AsyncValue.data([]);
  }

  void reset() {
    state = const AsyncValue.loading();
  }
}

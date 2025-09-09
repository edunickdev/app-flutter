import 'package:doublevpartnersapp/repository/controllers/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountryStateNotifier
    extends StateNotifier<AsyncValue<Map<String, List<String>>>> {
  CountryStateNotifier() : super(const AsyncValue.loading());

  final UserController _userController = UserController();

  Future<void> fetchData() async {
    try {
      final data = await _userController.fetchCountries();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
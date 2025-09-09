import 'package:doublevpartnersapp/repository/db/user_dao.dart';
import 'package:doublevpartnersapp/repository/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersNotifier extends StateNotifier<AsyncValue<List<UserModel>>> {
  UsersNotifier(this._dao) : super(const AsyncValue.loading());

  final UserDao _dao;

  Future<void> loadUsers() async {
    state = const AsyncValue.loading();
    try {
      final users = await _dao.getUsers();
      state = AsyncValue.data(users);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteUser(String id) async {
    final success = await _dao.deleteUser(id);
    if (success) {
      await loadUsers();
    }
  }
}

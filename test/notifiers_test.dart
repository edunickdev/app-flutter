import 'package:doublevpartnersapp/repository/db/user_dao.dart';
import 'package:doublevpartnersapp/repository/models/user_model.dart';
import 'package:doublevpartnersapp/repository/notifiers/country_state_notifier.dart';
import 'package:doublevpartnersapp/repository/notifiers/municipality_notifier.dart';
import 'package:doublevpartnersapp/repository/notifiers/users_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeUserDao implements UserDao {
  FakeUserDao(this._users);

  List<UserModel> _users;

  @override
  Future<bool> insertUser(UserModel user) async {
    _users.add(user);
    return true;
  }

  @override
  Future<List<UserModel>> getUsers() async => _users;

  @override
  Future<bool> deleteUser(String id) async {
    _users.removeWhere((u) => u.id == id);
    return true;
  }
}

class FakeUserController {
  Future<Map<String, List<String>>> fetchCountries() async => {
    'A': ['B'],
  };

  Future<List<String>> fetchMunicipalitiesGet(
    String country,
    String department,
  ) async => ['M1', 'M2'];
}

class TestCountryStateNotifier extends CountryStateNotifier {
  TestCountryStateNotifier(this.controller) : super();

  final FakeUserController controller;

  @override
  Future<void> fetchData() async {
    try {
      final data = await controller.fetchCountries();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

class TestMunicipalityNotifier extends MunicipalityNotifier {
  TestMunicipalityNotifier(this.controller) : super();

  final FakeUserController controller;

  @override
  Future<void> fetchMunicipalities(String country, String department) async {
    state = const AsyncValue.loading();
    try {
      final data = await controller.fetchMunicipalitiesGet(country, department);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

void main() {
  group('UsersNotifier', () {
    test('loadUsers and deleteUser update state', () async {
      final dao = FakeUserDao([
        UserModel(id: '1', names: 'A', lastnames: 'B', addresses: const []),
      ]);
      final notifier = UsersNotifier(dao);
      await notifier.loadUsers();
      expect(notifier.state.value!.length, 1);

      await notifier.deleteUser('1');
      expect(notifier.state.value, isEmpty);
    });
  });

  group('CountryStateNotifier', () {
    test('fetchData sets state to data', () async {
      final notifier = TestCountryStateNotifier(FakeUserController());
      await notifier.fetchData();
      expect(notifier.state.value, {
        'A': ['B'],
      });
    });
  });

  group('MunicipalityNotifier', () {
    test('fetchMunicipalities sets state to data', () async {
      final notifier = TestMunicipalityNotifier(FakeUserController());
      await notifier.fetchMunicipalities('A', 'B');
      expect(notifier.state.value, ['M1', 'M2']);
    });

    test('clearData resets to empty list', () {
      final notifier = MunicipalityNotifier();
      notifier.state = const AsyncValue.data(['x']);
      notifier.clearData();
      expect(notifier.state.value, isEmpty);
    });
  });
}

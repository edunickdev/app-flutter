import 'package:doublevpartnersapp/repository/db/user_dao.dart';
import 'package:doublevpartnersapp/repository/models/user_model.dart';
import 'package:doublevpartnersapp/repository/notifiers/country_state_notifier.dart';
import 'package:doublevpartnersapp/repository/notifiers/municipality_notifier.dart';
import 'package:doublevpartnersapp/repository/notifiers/users_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doublevpartnersapp/repository/db/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  ref.onDispose(AppDatabase.instance.close);
  return AppDatabase.instance;
});

final modeProvider = StateProvider<bool>((ref) => false);
final colorProvider = StateProvider<int>((ref) => 0);

final countriesProvider =
    StateNotifierProvider<
      CountryStateNotifier,
      AsyncValue<Map<String, List<String>>>
    >((ref) {
      return CountryStateNotifier();
    });

final departmentsProvider = Provider<AsyncValue<List<String>>>((ref) {
  final countries = ref.watch(countriesProvider);
  final selected = ref.watch(countrySelectedProvider);
  return countries.when(
    data: (data) =>
        AsyncValue.data(selected != null ? data[selected] ?? [] : []),
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});
final municipalitiesProvider =
    StateNotifierProvider<MunicipalityNotifier, AsyncValue<List<String>>>((
      ref,
    ) {
      return MunicipalityNotifier();
    });

final countrySelectedProvider = StateProvider<String?>((ref) => null);
final departmentSelectedProvider = StateProvider<String?>((ref) => null);
final municipalitySelectedProvider = StateProvider<String?>((ref) => null);

final userDaoProvider = Provider<UserDao>((ref) {
  return UserDao(ref.read(databaseProvider));
});

final usersProvider =
    StateNotifierProvider<UsersNotifier, AsyncValue<List<UserModel>>>((ref) {
      final notifier = UsersNotifier(ref.read(userDaoProvider));
      notifier.loadUsers();
      return notifier;
    });

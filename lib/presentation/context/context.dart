import 'package:doublevpartnersapp/repository/notifiers/user_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doublevpartnersapp/repository/db/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  ref.onDispose(AppDatabase.instance.close);
  return AppDatabase.instance;
});

final modeProvider = StateProvider<bool>((ref) => false);
final colorProvider = StateProvider<int>((ref) => 0);

final countriesProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<List<String>>>((ref) {
      return UserNotifier();
    });
final departmentsProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<List<String>>>((ref) {
      return UserNotifier();
    });
final municipalitiesProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<List<String>>>((ref) {
      return UserNotifier();
    });

final countrySelectedProvider = StateProvider<String?>((ref) => null);
final departmentSelectedProvider = StateProvider<String?>((ref) => null);
final municipalitySelectedProvider = StateProvider<String?>((ref) => null);

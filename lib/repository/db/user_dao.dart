import '../models/user_model.dart';
import '../models/address_model.dart';
import 'app_database.dart';

class UserDao {
  UserDao(this._appDatabase);

  final AppDatabase _appDatabase;

  Future<bool> insertUser(UserModel user) async {
    try {
      final db = await _appDatabase.database;
      await db.transaction((txn) async {
        await txn.insert('users', {
          'id': user.id,
          'names': user.names,
          'lastnames': user.lastnames,
        });

        for (final AddressModel address in user.addresses) {
          await txn.insert('addresses', {
            'userId': user.id,
            'country': address.country,
            'department': address.department,
            'municipality': address.municipality,
            'address': address.address,
          });
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}

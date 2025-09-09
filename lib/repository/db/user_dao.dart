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

  Future<List<UserModel>> getUsers() async {
    final db = await _appDatabase.database;
    final userMaps = await db.query('users');
    List<UserModel> users = [];
    for (final userMap in userMaps) {
      final addressMaps = await db.query(
        'addresses',
        where: 'userId = ?',
        whereArgs: [userMap['id']],
      );
      final addresses = addressMaps
          .map((a) => AddressModel.fromJson(a))
          .toList();
      users.add(
        UserModel(
          id: userMap['id'] as String,
          names: userMap['names'] as String,
          lastnames: userMap['lastnames'] as String,
          addresses: addresses,
        ),
      );
    }
    return users;
  }

  Future<bool> deleteUser(String id) async {
    try {
      final db = await _appDatabase.database;
      await db.transaction((txn) async {
        await txn.delete(
          'addresses',
          where: 'userId = ?',
          whereArgs: [id],
        );
        await txn.delete(
          'users',
          where: 'id = ?',
          whereArgs: [id],
        );
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}

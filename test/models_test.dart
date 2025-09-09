import 'package:flutter_test/flutter_test.dart';
import 'package:doublevpartnersapp/repository/models/address_model.dart';
import 'package:doublevpartnersapp/repository/models/user_model.dart';

void main() {
  group('AddressModel', () {
    test('toJson and fromJson work correctly', () {
      final address = AddressModel(
        country: 'Colombia',
        department: 'Cundinamarca',
        municipality: 'Bogotá',
        address: 'Cra 1',
      );

      final json = address.toJson();
      final fromJson = AddressModel.fromJson(json);

      expect(fromJson.country, address.country);
      expect(fromJson.department, address.department);
      expect(fromJson.municipality, address.municipality);
      expect(fromJson.address, address.address);
    });
  });

  group('UserModel', () {
    test('toJson and fromJson include addresses', () {
      final user = UserModel(
        id: '1',
        names: 'John',
        lastnames: 'Doe',
        addresses: [
          AddressModel(
            country: 'Colombia',
            department: 'Cundinamarca',
            municipality: 'Bogotá',
            address: 'Cra 1',
          ),
        ],
      );

      final json = user.toJson();
      final fromJson = UserModel.fromJson(json);

      expect(fromJson.id, user.id);
      expect(fromJson.names, user.names);
      expect(fromJson.lastnames, user.lastnames);
      expect(fromJson.addresses.length, 1);
      expect(fromJson.addresses.first.country, 'Colombia');
    });
  });
}

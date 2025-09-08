import 'package:doublevpartnersapp/repository/models/address_model.dart';

class UserModel {
  final String id;
  final String names;
  final String lastnames;
  final List<AddressModel> addresses;

  UserModel({
    required this.id,
    required this.names,
    required this.lastnames,
    required this.addresses,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var addressList = json['addresses'] as List;
    List<AddressModel> addressModels = addressList
        .map((i) => AddressModel.fromJson(i))
        .toList();

    return UserModel(
      id: json['id'],
      names: json['names'],
      lastnames: json['lastnames'],
      addresses: addressModels,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': names,
      'lastnames': lastnames,
      'addresses': addresses.map((i) => i.toJson()).toList(),
    };
  }
}

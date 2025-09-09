class AddressModel {
  final String country;
  final String department;
  final String municipality;
  final String address;

  AddressModel({
    required this.country,
    required this.department,
    required this.municipality,
    required this.address,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      country: json['country'] ?? '',
      department: json['department'] ?? '',
      municipality: json['municipality'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'department': department,
      'municipality': municipality,
      'address': address,
    };
  }
}

class VoucherModel {
  final String branchId;
  final String branchName;
  final String branchImage;
  final String discount;
  final String expireDate;
  final String restaurantName;
  final String restaurantId;
  final String worth;
  final String? id;
  final Map<String, dynamic> buyers;

  VoucherModel({
    required this.branchId,
    required this.branchName,
    required this.branchImage,
    required this.discount,
    required this.expireDate,
    required this.restaurantName,
    required this.restaurantId,
    required this.worth,
    this.id,
    this.buyers = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'branchId': branchId,
      'branchName': branchName,
      'branchImage': branchImage,
      'discount': discount,
      'expireDate': expireDate,
      'restaurantName': restaurantName,
      'restaurantId': restaurantId,
      'worth': worth,
      'buyers': buyers,
    };
  }

  factory VoucherModel.fromMap(Map<String, dynamic> map, String id) {
    return VoucherModel(
      branchId: map['branchId'] ?? '',
      branchName: map['branchName'] ?? '',
      branchImage: map['branchImage'] ?? '',
      discount: map['discount'] ?? '',
      expireDate: map['expireDate'] ?? '',
      restaurantName: map['restaurantName'] ?? '',
      restaurantId: map['restaurantId'] ?? '',
      worth: map['worth'] ?? '',
      id: id,
      buyers: Map<String, dynamic>.from(map['buyers'] ?? {}),
    );
  }
}

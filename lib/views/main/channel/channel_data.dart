class ChannelData {
  String restaurantName;
  String branchName;

  // Constructor to initialize the model
  ChannelData({
    required this.restaurantName,
    required this.branchName,
  });

  // Convert the model object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'restaurant_name': restaurantName,
      'branch_name': branchName,
    };
  }

  // Create a ChannelData instance from a Firestore document
  factory ChannelData.fromMap(Map<String, dynamic> map) {
    return ChannelData(
      restaurantName: map['restaurant_name'] ?? '',
      branchName: map['branch_name'] ?? '',
    );
  }
}

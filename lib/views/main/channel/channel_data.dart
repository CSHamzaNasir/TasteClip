class ChannelData {
  final String restaurantName;
  final String branchName;

  ChannelData({
    required this.restaurantName,
    required this.branchName,
  });

  Map<String, dynamic> toMap() {
    return {
      'restaurant_name': restaurantName,
      'branch_name': branchName,
    };
  }
}

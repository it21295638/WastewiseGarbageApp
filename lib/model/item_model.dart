class Item {
  final String imageUrl;
  final String description;
  final String phoneNumber;
  final String location;
  final bool approved;

  Item({
    required this.imageUrl,
    required this.description,
    required this.phoneNumber,
    required this.location,
    this.approved = false, // Default to false
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'description': description,
      'phoneNumber': phoneNumber,
      'location': location,
      'approved': approved,
    };
  }
}

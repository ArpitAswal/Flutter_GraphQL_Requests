class CharacterModel {
  CharacterModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.status});

  /// Factory constructor to create a User instance from JSON data
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      status: json['status'] as String,
    );
  }

  final String id;
  final String image;
  final String name;
  final String status;

  /// Convert User instance to JSON format
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'status': status};
  }

  Map<String, dynamic> toMap() {
    // Convert User instance to Map format
    return {
      'id': id,
      'name': name,
      'image': image,
      'status': status,
    };
  }
}

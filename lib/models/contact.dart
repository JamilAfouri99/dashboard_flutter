class Contact {
  static const String idProperty = 'id';
  static const String nameProperty = 'name';
  static const String positionProperty = 'position';
  static const String imageProperty = 'image';

  late final String id;
  late final String name;
  final String position;
  final String image;

  Contact({
    required this.id,
    required this.name,
    required this.position,
    required this.image,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json[idProperty],
        name: json[nameProperty],
        position: json[positionProperty],
        image: json[imageProperty],
      );

  Map<String, dynamic> toJson() => {
        idProperty: id,
        nameProperty: name,
        positionProperty: position,
        imageProperty: image,
      };
}

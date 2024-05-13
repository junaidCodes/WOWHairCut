class PlaceModel {
  final String name;
  final String formattedAddress;
  final double lat;
  final double lng;
  final String icon;
  final List<String> photoReferences;
  final double rating;

  PlaceModel({
    required this.name,
    required this.formattedAddress,
    required this.lat,
    required this.lng,
    required this.icon,
    required this.photoReferences,
    required this.rating,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json['name'],
      formattedAddress: json['formatted_address'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
      icon: json['icon'],
      photoReferences: json['photos'] != null
          ? List<String>.from(
              json['photos'].map((photo) => photo['photo_reference']))
          : [],
      rating: json['rating'] != null ? json['rating'].toDouble() : 0.0,
    );
  }
}

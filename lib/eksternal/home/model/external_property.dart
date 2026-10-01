class ExternalProperty {
  final String id;
  final String name;
  final String category;
  final String location;
  final String address;
  final String area;
  final String status;
  final String price;
  final String image;
  final List<String> gallery;
  final String shortDescription;
  final String description;
  final List<String> facilities;
  final List<ExternalSpace> spaces;

  const ExternalProperty({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.address,
    required this.area,
    required this.status,
    required this.price,
    required this.image,
    required this.gallery,
    required this.shortDescription,
    required this.description,
    required this.facilities,
    required this.spaces,
  });
}

class ExternalSpace {
  final String name;
  final String area;
  final String capacity;
  final String price;

  const ExternalSpace({
    required this.name,
    required this.area,
    required this.capacity,
    required this.price,
  });
}
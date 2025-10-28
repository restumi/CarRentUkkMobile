class Car {
  final String id;
  final String name;
  final String brand;
  final String seat;
  final String pricePerDay;
  final String image;
  final String createdAt;
  final String updatedAt;

  Car({
    required this.id,
    required this.name,
    required this.brand,
    required this.seat,
    required this.pricePerDay,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      seat: json['seat'],
      pricePerDay: json['price_per_day'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

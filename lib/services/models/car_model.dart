class Car {
  final int id;
  final String name;
  final String brand;
  final int seat;
  final int pricePerDay;
  final String image;

  Car({
    required this.id,
    required this.name,
    required this.brand,
    required this.seat,
    required this.pricePerDay,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'brand': brand,
    'seat': seat,
    'pricePerDay': pricePerDay,
    'image': image
  };

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as int,
      name: json['name'] as String,
      brand: json['brand'] as String,
      seat: json['seat'] as int,
      pricePerDay: json['price_per_day'] as int,
      image: json['image'] as String,
    );
  }
}

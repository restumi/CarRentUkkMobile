class CarsData {
  final String name;
  final String type;
  final String price;
  final String image;

  CarsData({
    required this.name,
    required this.type,
    required this.price,
    required this.image,
  });
}

List<CarsData> dummyCars = [
  CarsData(name: 'name', type: 'type', price: 'price', image: 'assets/images/cars/car1.png')
];
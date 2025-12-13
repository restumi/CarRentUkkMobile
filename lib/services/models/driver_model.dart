class Driver {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String status;
  final String image;

  Driver({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.status,
    required this.image,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      status: json['status'] as String,
      image: json['photo'] as String,
    );
  }
}

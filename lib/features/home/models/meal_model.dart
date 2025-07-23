class MealModel {
  int? id;
  String name;
  String imageUrl;
  String description;
  double rate;
  String time;

  MealModel({
     this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.rate,
    required this.time,
  });

  factory MealModel.fromMap(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      rate: json['rate'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'rate': rate,
      'time': time,
    };
  }
}

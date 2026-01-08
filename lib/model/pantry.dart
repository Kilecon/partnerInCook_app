import 'package:partner_in_cook/model/fridge.dart';

class Pantry {
  final String id;
  final String name;
  final List<Fridge> fridges;

  Pantry({
    required this.id,
    required this.name,
    required this.fridges,
  });

  factory Pantry.fromJson(Map<String, dynamic> json) {
    return Pantry(
      id: json['id'] as String,
      name: json['name'] as String,
      fridges: (json['fridges'] as List<dynamic>)
          .map((e) => Fridge.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fridges': fridges.map((e) => e.toJson()).toList(),
    };
  }
}

import '../../ domain/entities/weight.dart';

class WeightModel extends Weight {
  WeightModel({required int? id, required String name})
      : super(id: id, name: name);
  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(id: json['id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

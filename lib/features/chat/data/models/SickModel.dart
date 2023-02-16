import '../../ domain/entities/sick.dart';

class SickModel extends Sick {
  SickModel({String? toWho, int? id, required bool you, required String meg})
      : super(toWho: toWho, id: id, you: you, meg: meg);
  factory SickModel.fromJson(Map<String, dynamic> json) {
    return SickModel(
        id: json['id'] ?? '',
        toWho: json['toWho'] ?? '',
        meg: json['meg'] ?? '',
        you: json['you'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'you': you, 'meg': meg, 'toWho': toWho};
  }
}

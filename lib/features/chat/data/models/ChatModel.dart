import '../../ domain/entities/ChatEntities.dart';

class MessageModel extends ChatEntities {
  MessageModel({String? toWho, int? id, required bool you, required String meg})
      : super(toWho: toWho, id: id, you: you, meg: meg);
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        id: json['id'] ?? '',
        toWho: json['toWho'] ?? '',
        meg: json['meg'] ?? '',
        you: json['you'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'you': you, 'meg': meg, 'toWho': toWho};
  }
}

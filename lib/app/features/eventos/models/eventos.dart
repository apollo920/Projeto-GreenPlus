import 'dart:convert';

class EventoModel {
  final String? image;
  final String? observacoes;

  EventoModel({required this.image, required this.observacoes});

  EventoModel copyWith({
    String? image,
    String? observacoes,
  }) {
    return EventoModel(
      image: image ?? this.image,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  static EventoModel? fromJson(String? source) {
    if (source?.isEmpty ?? true) return EventoModel.fromMap({});
    return EventoModel.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, String> toMap() {
    return {'image': image ?? '', 'observacoes': observacoes ?? ''};
  }

  factory EventoModel.fromMap(Map<String, dynamic> map) {
    return EventoModel(
        image: map['image'] as String?,
        observacoes: map['observacoes'] as String?);
  }
}

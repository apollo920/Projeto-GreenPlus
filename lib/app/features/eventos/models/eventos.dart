import 'dart:convert';

class EventoModel {
  final String? image;
  final String? observacoes;
  final String? id;

  EventoModel({required this.image, required this.observacoes, required this.id});

  EventoModel copyWith({
    String? image,
    String? observacoes,
    String? id,
  }) {
    return EventoModel(
      image: image ?? this.image,
      observacoes: observacoes ?? this.observacoes,
      id: id ?? this.id,
    );
  }

  static EventoModel? fromJson(String? source) {
    if (source?.isEmpty ?? true) return EventoModel.fromMap({});
    return EventoModel.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, String> toMap() {
    return {
    'image': image ?? '', 
    'observacoes': observacoes ?? '',
    'id': id ?? ''};
  }

  factory EventoModel.fromMap(Map<String, dynamic> map) {
    return EventoModel(
        image: map['image'] as String?,
        observacoes: map['observacoes'] as String?,
        id: map['id']?.toString());
  }
  dynamic operator [](String key) {
    switch (key) {
      case 'id':
        return id;
      case 'image':
        return image;
      case 'observacoes':
        return observacoes;
      default:
        throw Exception('Invalid key!');
    }
  }
}

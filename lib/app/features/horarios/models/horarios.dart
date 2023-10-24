import 'dart:convert';

class HorarioModel {
  final String? pdf;
  final String? id;

  HorarioModel({required this.pdf, required this.id});

  HorarioModel copyWith({
    String? pdf,
    String? id,
  }) {
    return HorarioModel(
      pdf: pdf ?? this.pdf,
      id: id ?? this.id,
    );
  }

  static HorarioModel? fromJson(String? source) {
    if (source?.isEmpty ?? true) return HorarioModel.fromMap({});
    return HorarioModel.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, String> toMap() {
    return {
    'pdf': pdf ?? '', 
    'id': id ?? ''};
  }

  factory HorarioModel.fromMap(Map<String, dynamic> map) {
    return HorarioModel(
        pdf: map['pdf'] as String?,
        id: map['id'] as String?);
  }
  dynamic operator [](String key) {
    switch (key) {
      case 'id':
        return id;
      case 'pdf':
        return pdf;
      default:
        throw Exception('Invalid key!');
    }
  }
}

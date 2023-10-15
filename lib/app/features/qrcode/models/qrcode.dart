import 'dart:convert';

class QrCodeModel {
  final String? id;
  final String? title;
  final String? content;
  final String? icon;
  final String? type;

  QrCodeModel({required this.title, required this.content, required this.icon, required this.type, this.id});

  QrCodeModel copyWith({
    String? title,
    String? content,
    String? id,
    String? icon,
    String? type,
  }) {
    return QrCodeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      icon: icon ?? this.icon,
      type: type ?? this.type,
    );
  }


  static QrCodeModel? fromJson(String? source) {
    if (source?.isEmpty ?? true) return QrCodeModel.fromMap({});
    return QrCodeModel.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'icon': icon,
      'type': type,
      'id': id,
    };
  }

  factory QrCodeModel.fromMap(Map<String, dynamic> map) {
    return QrCodeModel(
      title: map['title'] as String?,
      content: map['content'] as String?,
      icon: map['icon'] as String?,
      type: map['type'] as String?,
      id: map['id'] as String?,
    );
  }
}

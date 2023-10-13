import 'dart:convert';

class QrCode {
  
  final String? title;
  final String? content;
  final String? icon;

  QrCode({required this.title, required this.content, required this.icon});

  QrCode copyWith({
    String? title,
    String? content,
  }) {
    return QrCode(
      title: title ?? this.title,
      content: content ?? this.content,
      icon: icon ?? this.icon,
    );
  }


  static QrCode? fromJson(String? source) {
    if (source?.isEmpty ?? true) return QrCode.fromMap({});
    return QrCode.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'icon': icon,
    };
  }

  factory QrCode.fromMap(Map<String, dynamic> map) {
    return QrCode(
      title: map['title'] as String?,
      content: map['content'] as String?,
      icon: map['icon'] as String?,
    );
  }
}

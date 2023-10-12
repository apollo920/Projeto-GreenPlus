import 'dart:convert';

class QrCode {
  
  final String? title;
  final String? action;
  final String? icon;

  QrCode({required this.title, required this.action, required this.icon});

  QrCode copyWith({
    String? title,
    String? action,
  }) {
    return QrCode(
      title: title ?? this.title,
      action: action ?? this.action,
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
      'action': action,
      'icon': icon,
    };
  }

  factory QrCode.fromMap(Map<String, dynamic> map) {
    return QrCode(
      title: map['title'] as String?,
      action: map['action'] as String?,
      icon: map['icon'] as String?,
    );
  }
}

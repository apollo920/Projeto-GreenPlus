import 'dart:convert';

class EscolhaAdm {
  
  final String? title;
  final String? action;
  final String? icon;

  EscolhaAdm({required this.title, required this.action, required this.icon});

  EscolhaAdm copyWith({
    String? title,
    String? action,
    String? icon,
  }) {
    return EscolhaAdm(
      title: title ?? this.title,
      action: action ?? this.action,
      icon: icon ?? this.icon,
    );
  }


  static EscolhaAdm? fromJson(String? source) {
    if (source?.isEmpty ?? true) return EscolhaAdm.fromMap({});
    return EscolhaAdm.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'action': action,
      'icon': icon,
    };
  }

  factory EscolhaAdm.fromMap(Map<String, dynamic> map) {
    return EscolhaAdm(
      title: map['title'] as String?,
      action: map['action'] as String?,
      icon: map['icon'] as String?,
    );
  }
}

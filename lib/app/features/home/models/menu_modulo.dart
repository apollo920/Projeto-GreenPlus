import 'dart:convert';

class MenuModulo {
  
  final String? title;
  final String? action;
  final String? icon;

  MenuModulo({required this.title, required this.action, required this.icon});

  MenuModulo copyWith({
    String? title,
    String? action,
  }) {
    return MenuModulo(
      title: title ?? this.title,
      action: action ?? this.action,
      icon: icon ?? this.icon,
    );
  }


  static MenuModulo? fromJson(String? source) {
    if (source?.isEmpty ?? true) return MenuModulo.fromMap({});
    return MenuModulo.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'action': action,
      'icon': icon,
    };
  }

  factory MenuModulo.fromMap(Map<String, dynamic> map) {
    return MenuModulo(
      title: map['title'] as String?,
      action: map['action'] as String?,
      icon: map['icon'] as String?,
    );
  }
}

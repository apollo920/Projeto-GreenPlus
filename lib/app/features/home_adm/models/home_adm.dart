import 'dart:convert';

class HomeAdm {
  
  final String? title;
  final String? action;
  final String? icon;

  HomeAdm({required this.title, required this.action, required this.icon});

  HomeAdm copyWith({
    String? title,
    String? action,
    String? icon,
  }) {
    return HomeAdm(
      title: title ?? this.title,
      action: action ?? this.action,
      icon: icon ?? this.icon,
    );
  }


  static HomeAdm? fromJson(String? source) {
    if (source?.isEmpty ?? true) return HomeAdm.fromMap({});
    return HomeAdm.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'action': action,
      'icon': icon,
    };
  }

  factory HomeAdm.fromMap(Map<String, dynamic> map) {
    return HomeAdm(
      title: map['title'] as String?,
      action: map['action'] as String?,
      icon: map['icon'] as String?,
    );
  }
}

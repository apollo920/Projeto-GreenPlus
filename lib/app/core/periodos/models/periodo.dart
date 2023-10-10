import 'dart:convert';

class Periodo {

  final String? nome;
  final String? action;
  final String? icon;

  Periodo({required this.nome, required this.action, required this.icon});

  Periodo copyWith({
    String? nome,
    String? action,
  }) {
    return Periodo(
      nome: nome ?? this.nome,
      action: action ?? this.action,
      icon: icon ?? this.icon,
    );
  }


  static Periodo? fromJson(String? source) {
    if (source?.isEmpty ?? true) return Periodo.fromMap({});
    return Periodo.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'action': action,
      'icon': icon,
    };
  }

  factory Periodo.fromMap(Map<String, dynamic> map) {
    return Periodo(
      nome: map['nome'] as String?,
      action: map['action'] as String?,
      icon: map['icon'] as String?,
    );
  }
}

import 'dart:convert';

class Curso {

  final String? nome;
  final String? action;
  final String? icon;

  Curso({required this.nome, required this.action, required this.icon});

  Curso copyWith({
    String? nome,
    String? action,
  }) {
    return Curso(
      nome: nome ?? this.nome,
      action: action ?? this.action,
      icon: icon ?? this.icon,
    );
  }


  static Curso? fromJson(String? source) {
    if (source?.isEmpty ?? true) return Curso.fromMap({});
    return Curso.fromMap(json.decode(source!));
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'action': action,
      'icon': icon,
    };
  }

  factory Curso.fromMap(Map<String, dynamic> map) {
    return Curso(
      nome: map['nome'] as String?,
      action: map['action'] as String?,
      icon: map['icon'] as String?,
    );
  }
}

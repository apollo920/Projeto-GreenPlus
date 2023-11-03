import 'dart:convert';

class Curso {

  final String? nome;
  final String? action;
  final String? icon;
  final String? id;

  Curso({required this.nome, required this.action, required this.icon, required this.id});

  Curso copyWith({
    String? nome,
    String? action,
    String? icon,
    String? id
  }) {
    return Curso(
      nome: nome ?? this.nome,
      action: action ?? this.action,
      icon: icon ?? this.icon,
      id: id ?? this.id,
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
      'id': id,
    };
  }

  factory Curso.fromMap(Map<String, dynamic> map) {
    return Curso(
      nome: map['nome'] as String?,
      action: map['action'] as String?,
      icon: map['icon'] as String?,
      id: map['id'] as String?,
    );
  }
}

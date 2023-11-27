import 'dart:async';

class Habilidad {
  int? _id;
  int? get id => _id;
  set id(int? value) => _id = value;

  String? _tipoHabilidad;
  String? get tipoHabilidad => _tipoHabilidad;
  set tipoHabilidad(String? value) => _tipoHabilidad = value;

  String? _habilidad;
  String? get habilidad => _habilidad;
  set habilidad(String? value) => _habilidad = value;

  String? _habilidad_en;
  String? get habilidad_en => _habilidad_en;
  set habilidad_en(String? value) => _habilidad_en = value;

  Habilidad({
    int? id,
    String? tipoHabilidad,
    String? habilidad,
    String? habilidad_en
  }) : _id = id, _tipoHabilidad = tipoHabilidad, _habilidad = habilidad, _habilidad_en = habilidad_en;

  factory Habilidad.fromJson(Map<String, dynamic> json) {
    return Habilidad(
      id: json['id'],
      tipoHabilidad: json['tipoHabilidad'],
      habilidad: json['habilidad'],
      habilidad_en: json['habilidad_en'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'tipoHabilidad': _tipoHabilidad,
      'habilidad': _habilidad,
      'habilidad_en': _habilidad_en,
    };
  }
}
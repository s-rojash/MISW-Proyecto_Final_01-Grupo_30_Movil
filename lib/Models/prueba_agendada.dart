import 'dart:async';

class PruebaAgendada {
  int? _id;
  int? get id => _id;
  set id(int? value) => _id = value;

  String? _fecha;
  String? get fecha => _fecha;
  set fecha(String? value) => _fecha = value;

  String? _nombrePrueba;
  String? get nombrePrueba => _nombrePrueba;
  set nombrePrueba(String? value) => _nombrePrueba = value;

  String? _estado;
  String? get estado => _estado;
  set estado(String? value) => _estado = value;

  PruebaAgendada({
    int? id,
    String? fecha,
    String? nombrePrueba,
    String? estado,
  }) : _id = id, _fecha = fecha, _nombrePrueba = nombrePrueba, _estado = estado;

  factory PruebaAgendada.fromJson(Map<String, dynamic> json) {
    return PruebaAgendada(
      id: json['id'],
      fecha: json['fecha'],
      nombrePrueba: json['nombrePrueba'],
      estado: json['estado'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'fecha': _fecha,
      'nombrePrueba': _nombrePrueba,
      'estado': _estado,
    };
  }
}
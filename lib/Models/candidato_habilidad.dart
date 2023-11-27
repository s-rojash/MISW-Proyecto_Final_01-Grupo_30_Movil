import 'dart:async';

import 'package:abcjobs_movil/Models/candidato.dart';

import 'habilidad.dart';
import 'id.dart';

class CandidatoHabilidad {
  int? _id;
  int? get id => _id;
  set id(int? value) => _id = value;

  Id? _candidato;
  Id? get candidato => _candidato;
  set candidato(Id? value) => _candidato = value;

  Id? _habilidad;
  Id? get habilidad => _habilidad;
  set habilidad(Id? value) => _habilidad = value;

  CandidatoHabilidad({
    int? id,
    Id? candidato,
    Id? habilidad,
  }) : _id = id, _candidato = candidato, _habilidad = habilidad;

  factory CandidatoHabilidad.fromJson(Map<String, dynamic> json) {
    return CandidatoHabilidad(
      id: json['id'],
      candidato: json['candidato'],
      habilidad: json['habilidad'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'candidato': _candidato,
      'habilidad': _habilidad
    };
  }
}
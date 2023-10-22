import 'dart:async';

class Candidato {
  int? _id;
  int? get id => _id;
  set id(int? value) => _id = value;

  String? _nombres;
  String? get nombres => _nombres;
  set nombres(String? value) => _nombres = value;

  String? _apellidos;
  String? get apellidos => _apellidos;
  set apellidos(String? value) => _apellidos = value;
  String? _email;
  String? get email => _email;
  set email(String? value) => _email = value;

  String? _celular;
  String? get celular => _celular;
  set celular(String? value) => _celular = value;

  String? _tipoDocumento;
  String? get tipoDocumento => _tipoDocumento;
  set tipoDocumento(String? value) => _tipoDocumento = value;

  double? _numDocumento;
  double? get numDocumento => _numDocumento;
  set numDocumento(double? value) => _numDocumento = value;

  Candidato({
    int? id,
    String? nombres,
    String? apellidos,
    String? email,
    String? celular,
    String? tipoDocumento,
    double? numDocumento,
  }) : _id = id, _numDocumento = numDocumento, _tipoDocumento = tipoDocumento, _celular = celular, _email = email, _apellidos = apellidos, _nombres = nombres;

  factory Candidato.fromJson(Map<String, dynamic> json) {
    return Candidato(
      id: json['id'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      email: json['email'],
      celular: json['celular'],
      tipoDocumento: json['tipoDocumento'],
      numDocumento: json['numDocumento'] as double,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'nombres': _nombres,
      'apellidos': _apellidos,
      'email': _email,
      'celular': _celular,
      'tipoDocumento': _tipoDocumento,
      'numDocumento': _numDocumento,
    };
  }
}
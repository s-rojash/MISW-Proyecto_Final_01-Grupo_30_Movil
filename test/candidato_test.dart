import 'package:abcjobs_movil/Models/candidato.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  test('Probar inicialización de todas las variables del modelo de candidatos',
      () async {
    int id = 123;
    String nombres = "Nombres de prueba";
    String apellidos = "Apellidos de prueba";
    String email = "email@test.com";
    String celular = "31234545678";
    String tipoDocumento = "C.C.";
    String numDocumento = "ASD123456";
    Candidato candidato = Candidato(
        id: id,
        nombres: nombres,
        apellidos: apellidos,
        email: email,
        celular: celular,
        tipoDocumento: tipoDocumento,
        numDocumento: numDocumento);

    expect(candidato.id, id);
    expect(candidato.nombres, nombres);
    expect(candidato.apellidos, apellidos);
    expect(candidato.email, email);
    expect(candidato.celular, celular);
    expect(candidato.tipoDocumento, tipoDocumento);
    expect(candidato.numDocumento, numDocumento);
  });

  test('Probar creación desde json', () async {
    final candidatoJson = {
      'id': 123,
      'nombres': "Nombres de prueba",
      'apellidos': "Apellidos de prueba",
      'email': "email@test.com",
      'celular': "31234545678",
      'tipoDocumento': "C.C.",
      'numDocumento': "ASD123456"
    };

    Candidato candidato = Candidato.fromJson(candidatoJson);

    expect(candidato.id, candidatoJson['id']);
    expect(candidato.nombres, candidatoJson['nombres']);
    expect(candidato.apellidos, candidatoJson['apellidos']);
    expect(candidato.email, candidatoJson['email']);
    expect(candidato.celular, candidatoJson['celular']);
    expect(candidato.tipoDocumento, candidatoJson['tipoDocumento']);
    expect(candidato.numDocumento, candidatoJson['numDocumento']);
  });

  test('Probar serialización a json', () async {
    Candidato candidato = Candidato(
        id: 12,
        nombres: "Nombres de prueba",
        apellidos: "Apellidos de prueba",
        email: "email@test.com",
        celular: "31234545678",
        tipoDocumento: "C.C.",
        numDocumento: "ASD123456");

    final candidatoJson = candidato.toJson();

    expect(candidato.id, candidatoJson['id']);
    expect(candidato.nombres, candidatoJson['nombres']);
    expect(candidato.apellidos, candidatoJson['apellidos']);
    expect(candidato.email, candidatoJson['email']);
    expect(candidato.celular, candidatoJson['celular']);
    expect(candidato.tipoDocumento, candidatoJson['tipoDocumento']);
    expect(candidato.numDocumento, candidatoJson['numDocumento']);
  });

  test('Probar setters del modelo', () async {
    Candidato candidato = Candidato();
    candidato.id =  13;
    candidato.nombres= "Nombres de prueba";
    candidato.apellidos= "Apellidos de prueba";
    candidato.email= "email@test.com";
    candidato.celular= "31234545678";
    candidato.tipoDocumento= "C.C.";
    candidato.numDocumento= "ASD123456";

    expect(candidato.id, 13);
    expect(candidato.nombres, "Nombres de prueba");
    expect(candidato.apellidos, "Apellidos de prueba");
    expect(candidato.email,"email@test.com");
    expect(candidato.celular, "31234545678");
    expect(candidato.tipoDocumento, "C.C.");
    expect(candidato.numDocumento, "ASD123456");
  });

}

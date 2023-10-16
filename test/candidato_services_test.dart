import 'package:abcjobs_movil/BackendServices/candidato_services.dart';
import 'package:abcjobs_movil/Models/candidato.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  test('Probar inicio de sesión con usuario y contraseña válidos', () async {
    final candidatoServices = CandidatoServices();
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode({
        'id':123,
        'email': 'test@test.com'
      }),200);
    });
    final respuesta = await candidatoServices.authenticarCandidato("test@test.com", "123456");
    expect(respuesta?.id, 123);
  });

  test('Probar inicio de sesión con usuario y contraseña errados', () async {
    final candidatoServices = CandidatoServices();
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode({
      }),200);
    });
    final respuesta = await candidatoServices.authenticarCandidato("test@test.com", "123456XX");
    expect(respuesta?.id, null);
  });


  test('Probar registro satisfactorio', () async {
    final candidatoServices = CandidatoServices();
    Candidato candidato = Candidato.fromJson({
      'id' : 123,
      'nombres': "Nombres de prueba",
      'apellidos': "Nombres de prueba",
      'email': "Nombres de prueba",
      'celular': "Nombres de prueba",
      'tipoDocumento': "Nombres de prueba",
      'numDocumento':"Nombres de prueba",
    });
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode(candidato),200);
    });
    final respuesta = await candidatoServices.registrarCandidato(candidato, '12345');
    expect(respuesta?.id, isNotNull);
    expect(respuesta?.nombres, candidato.nombres);
    expect(respuesta?.apellidos, candidato.apellidos);
    expect(respuesta?.email, candidato.email);
    expect(respuesta?.celular, candidato.celular);
    expect(respuesta?.tipoDocumento, candidato.tipoDocumento);
    expect(respuesta?.numDocumento, candidato.numDocumento);
  });


  test('Probar registro errado', () async {
    final candidatoServices = CandidatoServices();
    Candidato candidato = Candidato.fromJson({
      'nombres': "Nombres de prueba",
      'apellidos': "Nombres de prueba",
      'email': "Nombres de prueba",
      'celular': "Nombres de prueba",
      'tipoDocumento': "Nombres de prueba",
      'numDocumento':"Nombres de prueba",
    });
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode(candidato),200);
    });
    final respuesta = await candidatoServices.registrarCandidato(candidato, '12345');
    expect(respuesta?.id, isNull);
  });

}
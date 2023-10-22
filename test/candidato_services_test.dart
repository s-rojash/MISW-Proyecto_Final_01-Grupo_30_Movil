import 'package:abcjobs_movil/BackendServices/candidato_services.dart';
import 'package:abcjobs_movil/Models/candidato.dart';
import 'package:abcjobs_movil/Utils/utils.dart';
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
        'nombres': "Nombres de prueba",
        'apellidos': "Nombres de prueba",
        'email': "Nombres de prueba",
        'celular': "Nombres de prueba",
        'tipoDocumento': "Nombres de prueba",
        'numDocumento': 123456 + 0.0,
      }),200);
    });
    final (serviceStatus, candidato) = await candidatoServices.authenticarCandidato("test@test.com", "123456");
    expect(serviceStatus, ServiceStatus.Ok);
    expect(candidato?.id, 123);
  });

  test('Probar inicio de sesión con usuario y contraseña errados', () async {
    final candidatoServices = CandidatoServices();
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode({
        'id' : 123,
        'nombres': "Nombres de prueba",
        'apellidos': "Nombres de prueba",
        'email': "Nombres de prueba",
        'celular': "Nombres de prueba",
        'tipoDocumento': "Nombres de prueba",
        'numDocumento': 123456 + 0.0,
      }),404);
    });
    final (serviceStatus, candidato) = await candidatoServices.authenticarCandidato("test@test.com", "123456XX");
    expect(serviceStatus, ServiceStatus.NotFound);
    expect(candidato?.id, null);
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
      'numDocumento': 123456 + 0.0,
    });
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode(candidato),200);
    });
    final (serviceStatus, candidatoRespuesta) = await candidatoServices.registrarCandidato(candidato, '12345');
    expect(serviceStatus, ServiceStatus.Ok);
    expect(candidatoRespuesta?.id, isNotNull);
    expect(candidatoRespuesta?.nombres, candidato.nombres);
    expect(candidatoRespuesta?.apellidos, candidato.apellidos);
    expect(candidatoRespuesta?.email, candidato.email);
    expect(candidatoRespuesta?.celular, candidato.celular);
    expect(candidatoRespuesta?.tipoDocumento, candidato.tipoDocumento);
    expect(candidatoRespuesta?.numDocumento, candidato.numDocumento);
  });


  test('Probar registro errado', () async {
    final candidatoServices = CandidatoServices();
    Candidato candidato = Candidato.fromJson({
      'nombres': "Nombres de prueba",
      'apellidos': "Nombres de prueba",
      'email': "Nombres de prueba",
      'celular': "Nombres de prueba",
      'tipoDocumento': "Nombres de prueba",
      'numDocumento': 123456 + 0.0,
    });
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode(candidato),200);
    });
    final (serviceStatus, candidatoRespuesta) = await candidatoServices.registrarCandidato(candidato, '12345');
    expect(serviceStatus, ServiceStatus.Ok);
    expect(candidatoRespuesta?.id, isNull);
  });

}
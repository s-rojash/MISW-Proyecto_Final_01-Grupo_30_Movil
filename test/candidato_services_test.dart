import 'package:abcjobs_movil/BackendServices/candidato_services.dart';
import 'package:abcjobs_movil/Models/candidato.dart';
import 'package:abcjobs_movil/Models/candidato_habilidad.dart';
import 'package:abcjobs_movil/Models/habilidad.dart';
import 'package:abcjobs_movil/Models/id.dart';
import 'package:abcjobs_movil/Models/prueba_agendada.dart';
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


  test('Probar traer listado de pruebas asignadas', () async {
    final candidatoServices = CandidatoServices();
    List<PruebaAgendada> pruebasAgendadas = [PruebaAgendada.fromJson({
      'id': 1,
      'fecha': "2000-01-24",
      'nombrePrueba': "Prueba uno",
      'estado': "Asignada",
    })];
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode(pruebasAgendadas),200);
    });
    final (serviceStatus, pruebasAgendadasRespuesta) = await candidatoServices.listarPruebasAsignadas(1);
    expect(serviceStatus, ServiceStatus.Ok);
    expect(pruebasAgendadasRespuesta?.length, equals(1) );
    expect(pruebasAgendadasRespuesta?[0].id, equals(1) );
    expect(pruebasAgendadasRespuesta?[0].estado, equals("Asignada") );
  });

  test('Probar traer listado de habilidades', () async {
    final candidatoServices = CandidatoServices();
    List<Habilidad> habilidades = [Habilidad.fromJson({
      'id': 1,
      'tipoHabilidad': "Prueba",
      'habilidad': "Prueba uno",
      'habilidad_en': "Test one",
    })];
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode(habilidades),200);
    });
    final (serviceStatus, pruebasAgendadasRespuesta) = await candidatoServices.listarHabilidades();
    expect(serviceStatus, ServiceStatus.Ok);
    expect(pruebasAgendadasRespuesta?.length, equals(1) );
    expect(pruebasAgendadasRespuesta?[0].id, equals(1) );
    expect(pruebasAgendadasRespuesta?[0].habilidad, equals("Prueba uno") );
  });

  test('Probar traer listado de habilidades del candidato', () async {
    final candidatoServices = CandidatoServices();
    Candidato candidato = Candidato.fromJson({
      'id': 1,
      'nombres': "Nombres de prueba",
      'apellidos': "Nombres de prueba",
      'email': "Nombres de prueba",
      'celular': "Nombres de prueba",
      'tipoDocumento': "Nombres de prueba",
      'numDocumento': 123456 + 0.0,
    });
    Habilidad habilidad = Habilidad.fromJson({
      'id': 1,
      'tipoHabiliad': "prueba",
      'habilidad': "Desarrollo",
      'habilidad_en': "Developmen"
    });
    List<CandidatoHabilidad> habilidadesCandidato = [CandidatoHabilidad.fromJson({
      'id': 1,
      'candidato': Id.fromJson({'id': 1}),
      'habilidad': Id.fromJson({'id': 1}),
    })];
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode(habilidadesCandidato),200);
    });
    final (serviceStatus, habilidadesCandidatoRetornadas) = await candidatoServices.listarHabilidadesCandidato(1);
    expect(serviceStatus, ServiceStatus.Ok);
    expect(habilidadesCandidatoRetornadas?.length, equals(1) );
    //expect(habilidadesCandidatoRetornadas?[0], equals(1) );
  });

  test('Probar traer listado de habilidades del candidato con Id', () async {
    final candidatoServices = CandidatoServices();
    Candidato candidato = Candidato.fromJson({
      'id': 1,
      'nombres': "Nombres de prueba",
      'apellidos': "Nombres de prueba",
      'email': "Nombres de prueba",
      'celular': "Nombres de prueba",
      'tipoDocumento': "Nombres de prueba",
      'numDocumento': 123456 + 0.0,
    });
    Habilidad habilidad = Habilidad.fromJson({
      'id': 1,
      'tipoHabiliad': "prueba",
      'habilidad': "Desarrollo",
      'habilidad_en': "Developmen"
    });
    List<CandidatoHabilidad> habilidadesCandidato = [CandidatoHabilidad.fromJson({
      'id': 1,
      'candidato': Id.fromJson({'id': 1}),
      'habilidad': Id.fromJson({'id': 1}),
    })];
    candidatoServices.client = MockClient((request) async {
      return Response(json.encode(habilidadesCandidato),200);
    });
    final (serviceStatus, habilidadesCandidatoRetornadas) = await candidatoServices.listarHabilidadesCandidatoConId(1);
    expect(serviceStatus, ServiceStatus.Ok);
    expect(habilidadesCandidatoRetornadas?.length, equals(1) );
    //expect(habilidadesCandidatoRetornadas?[0], equals(1) );
  });
}
import 'package:abcjobs_movil/Models/candidato_habilidad.dart';
import 'package:abcjobs_movil/Models/prueba_agendada.dart';

import '../Models/habilidad.dart';
import '../Utils/configuration_settings.dart' as config show BackendURL, BackendURLEntrevistas;
import 'package:abcjobs_movil/Models/candidato.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import '../Utils/utils.dart';

class CandidatoServices {
  Client client = Client();


   Future<(ServiceStatus, Candidato?)> authenticarCandidato(String email, String password) async {
    String url = "${config.BackendURL}/candidatos/auth";
    final response = await client.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password
        })
    );
    Candidato? candidato;
    var serviceStatus = ServiceResponse.GetStatus(response.statusCode);
    if (serviceStatus == ServiceStatus.Ok){
        candidato = Candidato.fromJson(json.decode(response.body));
    }

    return (serviceStatus, candidato);
  }

  Future<(ServiceStatus, Candidato?)> registrarCandidato(Candidato datosCandidato, String password) async{
    String url = "${config.BackendURL}/candidatos/";
    final response = await client.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nombres': datosCandidato.nombres!,
          'apellidos': datosCandidato.apellidos!,
          'email': datosCandidato.email!,
          'celular': datosCandidato.celular!,
          'tipoDocumento': datosCandidato.tipoDocumento!,
          'numDocumento': datosCandidato.numDocumento!.toString(),
          'password': password,
        })
    );
    Candidato? candidato;
    var serviceStatus = ServiceResponse.GetStatus(response.statusCode);
    if (serviceStatus == ServiceStatus.Ok){
      candidato = Candidato.fromJson(json.decode(response.body));
    }
    return (serviceStatus, candidato);
  }

  Future<(ServiceStatus, Candidato?)> modificarCandidato(Candidato datosCandidato, String password) async{
    String url = "${config.BackendURL}/candidatos/";
    final response = await client.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, Object>{
          'id': datosCandidato.id!,
          'nombres': datosCandidato.nombres!,
          'apellidos': datosCandidato.apellidos!,
          'email': datosCandidato.email!,
          'celular': datosCandidato.celular!,
          'tipoDocumento': datosCandidato.tipoDocumento!,
          'numDocumento': datosCandidato.numDocumento!.toString(),
          'password': password,
        })
    );
    Candidato? candidato;
    var serviceStatus = ServiceResponse.GetStatus(response.statusCode);
    if (serviceStatus == ServiceStatus.Ok){
      candidato = Candidato.fromJson(json.decode(response.body));
    }
    return (serviceStatus, candidato);
  }

  Future<(ServiceStatus, List<PruebaAgendada>?)> listarPruebasAsignadas(int idCandidato) async{
    String url = "${config.BackendURLEntrevistas}/agenda-pruebas/ListarAgendaPruebaCandidado/" + idCandidato.toString();
    final response = await client.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    List<PruebaAgendada> pruebasAgendadas;
    var serviceStatus = ServiceResponse.GetStatus(response.statusCode);
    if (serviceStatus == ServiceStatus.Ok){
      Iterable lista = json.decode(response.body);
      pruebasAgendadas = List<PruebaAgendada>.from(lista.map((x) => PruebaAgendada.fromJson(x)));
      return (serviceStatus, pruebasAgendadas);
    } else {
      return (serviceStatus, null);
    }
  }

  Future<(ServiceStatus, List<Habilidad>?)> listarHabilidades() async{
    String url = "${config.BackendURL}/habilidades/";
    final response = await client.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    List<Habilidad> habilidades;
    var serviceStatus = ServiceResponse.GetStatus(response.statusCode);
    if (serviceStatus == ServiceStatus.Ok){
      Iterable lista = json.decode(response.body);
      habilidades = List<Habilidad>.from(lista.map((x) => Habilidad.fromJson(x)));
      return (serviceStatus, habilidades);
    } else {
      return (serviceStatus, null);
    }
  }
  Future<(ServiceStatus, List<int>?)> listarHabilidadesCandidato(int idCandidato) async{
    String url = "${config.BackendURL}/candidato-habilidades/candidatos/" + idCandidato.toString();
    final response = await client.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    var serviceStatus = ServiceResponse.GetStatus(response.statusCode);
    if (serviceStatus == ServiceStatus.Ok){
      Iterable lista = json.decode(response.body);
      List<int> habilidadesCandidato = [];
      for (final elemento in lista) {
        habilidadesCandidato.add(elemento["habilidad"]["id"] as int);
      }

      //habilidadesCandidato = List<CandidatoHabilidad>.from(lista.map((x) => CandidatoHabilidad.fromJson(x)));
      return (serviceStatus, habilidadesCandidato);
    } else {
      return (serviceStatus, null);
    }
  }

  Future<(ServiceStatus, List<int>?)> listarHabilidadesCandidatoConId(int idCandidato) async{
    String url = "${config.BackendURL}/candidato-habilidades/candidatos/" + idCandidato.toString();
    final response = await client.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    List<CandidatoHabilidad> habilidadesCandidato;
    var serviceStatus = ServiceResponse.GetStatus(response.statusCode);
    if (serviceStatus == ServiceStatus.Ok){
      Iterable lista = json.decode(response.body);
      List<int> habilidadesCandidato = [];
      for (final elemento in lista) {
        habilidadesCandidato.add(elemento["id"] as int);
      }

      //habilidadesCandidato = List<CandidatoHabilidad>.from(lista.map((x) => CandidatoHabilidad.fromJson(x)));
      return (serviceStatus, habilidadesCandidato);
    } else {
      return (serviceStatus, null);
    }
  }

  Future<ServiceStatus> limpiarHabilidadesCandidato(int idCandidato) async{
    var (serviceStatus, habilidadesCandidato) = await listarHabilidadesCandidatoConId(idCandidato);
    for (var habilidad in habilidadesCandidato!)
    {
      String url = "${config.BackendURL}/candidato-habilidades/" + habilidad.toString();
      final response = await client.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      serviceStatus = ServiceResponse.GetStatus(response.statusCode);
    }
    return serviceStatus;
  }
  Future<ServiceStatus> guardarHabilidadesCandidato(int idCandidato, List<int> habilidades) async{
      //await limpiarHabilidadesCandidato(idCandidato);
     var serviceStatus = ServiceStatus.ServiceError;
      String url = "${config.BackendURL}/candidato-habilidades/";
      for (var habilidad in habilidades)
      {
        final response = await client.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, Object>{
            "candidato": {
              "id": idCandidato
            },
            "habilidad": {
              "id": habilidad
            }}),
        );
        serviceStatus = ServiceResponse.GetStatus(response.statusCode);
      }
    return serviceStatus;
  }

}
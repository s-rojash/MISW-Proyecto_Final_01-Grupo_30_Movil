import '../Utils/configuration_settings.dart' as config show BackendURL;
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
}
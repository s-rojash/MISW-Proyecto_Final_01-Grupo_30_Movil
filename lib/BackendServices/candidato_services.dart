import '../Utils/configuration_settings.dart' as config show BackendURL;
import 'package:abcjobs_movil/Models/candidato.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class CandidatoServices {
  Client client = Client();


  authenticarCandidato(String email, String password) async {
    final response = await client.post(
        Uri.parse("${config.BackendURL}/candidatos/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          email: email,
          password: password
        })
    );
    Candidato candidato = Candidato.fromJson(json.decode(response.body));
    return candidato;
  }

  registrarCandidato(Candidato datosCandidato, String password) async{
    final response = await client.post(
        Uri.parse("${config.BackendURL}/candidatos/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nombres': datosCandidato.nombres!,
          'apellidos': datosCandidato.apellidos!,
          'email': datosCandidato.email!,
          'celular': datosCandidato.celular!,
          'tipoDocumento': datosCandidato.tipoDocumento!,
          'numDocumento': datosCandidato.numDocumento!,
          'password': password,
        })
    );
    Candidato candidato = Candidato.fromJson(json.decode(response.body));
    return candidato;
  }
}
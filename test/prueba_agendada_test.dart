import 'package:abcjobs_movil/Models/candidato.dart';
import 'package:abcjobs_movil/Models/prueba_agendada.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  test('Probar inicialización de todas las variables del modelo de pruebas agendadas',
      () async {
    int id = 123;
    String nombrePrueba = "Nombre de la prueba";
    String fecha = "2023-04-12";
    String estado = "Agendada";
    PruebaAgendada pruebaAgendada = PruebaAgendada(
        id: id,
        nombrePrueba: nombrePrueba,
        fecha: fecha,
        estado: estado);

    expect(pruebaAgendada.id, id);
    expect(pruebaAgendada.nombrePrueba, nombrePrueba);
    expect(pruebaAgendada.fecha, fecha);
    expect(pruebaAgendada.estado, estado);
  });

  test('Probar creación desde json', () async {
    final pruebaAgendadaJson = {
      'id': 123,
      'nombrePrueba': "Nombres de prueba",
      'fecha': "2023-04-12",
      'estado': "Agendada",
    };

    PruebaAgendada pruebaAgendada = PruebaAgendada.fromJson(pruebaAgendadaJson);

    expect(pruebaAgendada.id, pruebaAgendadaJson['id']);
    expect(pruebaAgendada.nombrePrueba, pruebaAgendadaJson['nombrePrueba']);
    expect(pruebaAgendada.fecha, pruebaAgendadaJson['fecha']);
    expect(pruebaAgendada.estado, pruebaAgendadaJson['estado']);
  });

  test('Probar serialización a json', () async {
    PruebaAgendada pruebaAgendada = PruebaAgendada(
        id: 12,
        nombrePrueba: "Nombres de prueba",
        fecha: "2023-01-12",
        estado: "Agendada");

    final pruebaAgendadaJson = pruebaAgendada.toJson();

    expect(pruebaAgendada.id, pruebaAgendadaJson['id']);
    expect(pruebaAgendada.nombrePrueba, pruebaAgendadaJson['nombrePrueba']);
    expect(pruebaAgendada.fecha, pruebaAgendadaJson['fecha']);
    expect(pruebaAgendada.estado, pruebaAgendadaJson['estado']);
  });

  test('Probar setters del modelo', () async {
    PruebaAgendada pruebaAgendada = PruebaAgendada();
    pruebaAgendada.id =  13;
    pruebaAgendada.nombrePrueba= "Nombres de prueba";
    pruebaAgendada.fecha= "2023-04-20";
    pruebaAgendada.estado= "Agendada";

    expect(pruebaAgendada.id, 13);
    expect(pruebaAgendada.nombrePrueba, "Nombres de prueba");
    expect(pruebaAgendada.fecha, "2023-04-20");
    expect(pruebaAgendada.estado,"Agendada");
  });

}

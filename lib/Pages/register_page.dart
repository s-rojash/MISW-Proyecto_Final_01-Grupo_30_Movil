import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

import '../BackendServices/candidato_services.dart';
import '../Models/candidato.dart';
import '../Utils/utils.dart';
import '../Utils/validaciones.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  Candidato candidato = Candidato();
  String password = "";
  bool isLoading = false;
  List<String> listaTiposDocumentosIdentificacion = <String>['CC', 'CE'];

  registrarCandidato() async {
    isLoading = true;
    var valid = _formKey.currentState!.validate();
    if (!valid) {
      isLoading = false;
      return;
    } else {
      var (status, candidatoRespuesta) = await CandidatoServices().registrarCandidato(candidato, password);
      switch(status){
        case ServiceStatus.Ok:
          Toast.show(AppLocalizations.of(context)!.registerOkMessage, duration: 3, gravity: Toast.center);
            break;
        case ServiceStatus.ServiceError:
          Toast.show(AppLocalizations.of(context)!.serviceResponseError, duration: 6, gravity: Toast.center);
          break;
        case ServiceStatus.NotFound:
          Toast.show(AppLocalizations.of(context)!.registerErrorMessage, duration: 6, gravity: Toast.center);
          break;
      }
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/logo.png'),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                        key: Key("_nombres"),
                        onChanged: (value) {
                          candidato.nombres = value;
                        },
                        validator: (value) => validarTexto(context, value, 4, 128),
                        decoration: InputDecoration(
                          label: RequiredLabel(
                              AppLocalizations.of(context)!.firstName),
                          suffixIcon: const Icon(Icons.cancel_outlined),
                        )),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                        key: Key("_apellidos"),
                        onChanged: (value) {
                          candidato.apellidos = value;
                        },
                        validator: (value) => validarTexto(context, value, 4, 128),
                        decoration: InputDecoration(
                          label: RequiredLabel(
                              AppLocalizations.of(context)!.lastName),
                          suffixIcon: const Icon(Icons.cancel_outlined),
                        )),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: DropdownMenu<String>(
                      key: Key("_tipoDocumento"),
                      width: 300,
                      label: RequiredLabel(AppLocalizations.of(context)!.idDocumentType),
                      dropdownMenuEntries: listaTiposDocumentosIdentificacion.map((item) {
                        return new DropdownMenuEntry(
                          value: item,
                          label: item,
                        );
                      }).toList(),
                      onSelected: (value) =>{
                        candidato.tipoDocumento = value,
                      },
                      inputDecorationTheme: InputDecorationTheme(
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: HexColor("00639A"),
                        ),
                        errorStyle: TextStyle(color: Colors.white),
                        prefixIconColor:
                        MaterialStateColor.resolveWith((Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        }),
                      )),
                    ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                        key: Key("_numDocumento"),
                        onChanged: (value) {
                          candidato.numDocumento = double.parse(value);
                        },
                        validator: (value) => validarNumero(context, int.parse(value!), 1,999999999999),
                        decoration: InputDecoration(
                          label: RequiredLabel(
                              AppLocalizations.of(context)!.idDocumentNumber),
                          suffixIcon: const Icon(Icons.cancel_outlined),
                        )),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                        key: Key("_celular"),
                        onChanged: (value) {
                          candidato.celular = value;
                        },
                        validator: (value) => validarTexto(context, value, 10, 10),
                        decoration: InputDecoration(
                          label: RequiredLabel(
                              AppLocalizations.of(context)!.mobilePhoneNumber),
                          suffixIcon: const Icon(Icons.cancel_outlined),
                        )),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                        key: Key("_email"),
                        onChanged: (value) {
                          candidato.email = value;
                        },
                        validator: (value) => validarEmail(context, value),
                        decoration: InputDecoration(
                          label: RequiredLabel(
                              AppLocalizations.of(context)!.email),
                          suffixIcon: const Icon(Icons.cancel_outlined),
                        )),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                        key: Key("_password"),
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) => validarTexto(context, value, 4, 32),
                        obscureText: true,
                        decoration: InputDecoration(
                          label: RequiredLabel(
                              AppLocalizations.of(context)!.password),
                          suffixIcon: const Icon(Icons.cancel_outlined),
                        )),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                        key: Key("_btnRegistrarCandidato"),
                        onPressed: () {
                          registrarCandidato();
                        },
                        child: isLoading? SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(),
                        ) : Text(AppLocalizations.of(context)!.register,
                            style: TextStyle(fontSize: 20))),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                        key: Key("_btnIrALogin"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: isLoading? SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(),
                        ) : Text(AppLocalizations.of(context)!.login,
                            style: TextStyle(fontSize: 20))),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

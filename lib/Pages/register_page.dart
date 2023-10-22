import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

import '../BackendServices/candidato_services.dart';
import '../Models/candidato.dart';
import '../Utils/utils.dart';
import '../Utils/validaciones.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  Candidato candidato = Candidato();
  String password = "";

  registrarCandidato() async {
    var valid = _formKey.currentState!.validate();
    if (!valid) {
      return;
    } else {
      var (status, candidatoRespuesta) = await CandidatoServices().registrarCandidato(candidato, password);
      switch(status){
        case ServiceStatus.Ok:
          Toast.show(AppLocalizations.of(context)!.registerOkMessage, duration: 6, gravity: Toast.center);
          break;
        case ServiceStatus.ServiceError:
          Toast.show(AppLocalizations.of(context)!.serviceResponseError, duration: 6, gravity: Toast.center);
          break;
        case ServiceStatus.NotFound:
          Toast.show(AppLocalizations.of(context)!.registerErrorMessage, duration: 6, gravity: Toast.center);
          break;
      }
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
                        onChanged: (value) {
                          candidato.nombres = value;
                        },
                        validator: (value) => validarTexto(context, value),
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
                        onChanged: (value) {
                          candidato.apellidos = value;
                        },
                        validator: (value) => validarTexto(context, value),
                        decoration: InputDecoration(
                          label: RequiredLabel(
                              AppLocalizations.of(context)!.lastName),
                          suffixIcon: const Icon(Icons.cancel_outlined),
                        )),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                        onChanged: (value) {
                          candidato.tipoDocumento = value;
                        },
                        validator: (value) => validarTexto(context, value),
                        decoration: InputDecoration(
                          label: RequiredLabel(
                              AppLocalizations.of(context)!.idDocumentType),
                          suffixIcon: const Icon(Icons.cancel_outlined),
                        )),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                        onChanged: (value) {
                          candidato.numDocumento = value;
                        },
                        validator: (value) => validarTexto(context, value),
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
                        onChanged: (value) {
                          candidato.celular = value;
                        },
                        validator: (value) => validarTexto(context, value),
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
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) => validarTexto(context, value),
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
                        onPressed: () {
                          registrarCandidato();
                        },
                        child: Text(AppLocalizations.of(context)!.register,
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

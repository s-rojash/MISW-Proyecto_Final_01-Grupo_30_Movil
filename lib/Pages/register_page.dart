import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../BackendServices/candidato_services.dart';
import '../Models/candidato.dart';
import '../Utils/utils.dart';

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
    print(valid);
    if (valid) {
      return;
    } else {
      CandidatoServices().registrarCandidato(candidato, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
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
                      decoration: InputDecoration(
                        label: RequiredLabel(
                            AppLocalizations.of(context)!.firstName),
                        suffixIcon: const Icon(Icons.cancel_outlined),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
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
                      onChanged: (value) {
                        candidato.apellidos = value;
                      },
                      validator: (value) {
                        print(value);
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.fieldRequired;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: RequiredLabel(
                            AppLocalizations.of(context)!.lastName),
                        suffixIcon: const Icon(Icons.cancel_outlined),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
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
                      onChanged: (value) {
                        candidato.tipoDocumento = value;
                      },
                      decoration: InputDecoration(
                        label: RequiredLabel(
                            AppLocalizations.of(context)!.idDocumentType),
                        suffixIcon: const Icon(Icons.cancel_outlined),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
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
                      onChanged: (value) {
                        candidato.numDocumento = value;
                      },
                      decoration: InputDecoration(
                        label: RequiredLabel(
                            AppLocalizations.of(context)!.idDocumentNumber),
                        suffixIcon: const Icon(Icons.cancel_outlined),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
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
                      onChanged: (value) {
                        candidato.celular = value;
                      },
                      decoration: InputDecoration(
                        label: RequiredLabel(
                            AppLocalizations.of(context)!.mobilePhoneNumber),
                        suffixIcon: const Icon(Icons.cancel_outlined),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
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
                      onChanged: (value) {
                        candidato.email = value;
                      },
                      decoration: InputDecoration(
                        label:
                            RequiredLabel(AppLocalizations.of(context)!.email),
                        suffixIcon: const Icon(Icons.cancel_outlined),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
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
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        label: RequiredLabel(
                            AppLocalizations.of(context)!.password),
                        suffixIcon: const Icon(Icons.cancel_outlined),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

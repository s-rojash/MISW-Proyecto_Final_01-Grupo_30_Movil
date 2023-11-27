import 'dart:ffi';

import 'package:abcjobs_movil/Pages/assigned_tests_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

import '../BackendServices/candidato_services.dart';
import '../Models/candidato.dart';
import '../Models/candidato_habilidad.dart';
import '../Models/habilidad.dart';
import '../Utils/utils.dart';
import '../Utils/validaciones.dart';
import 'login_page.dart';

class UserModifyPage extends StatefulWidget {
  Candidato candidato;
  String pwd;
  UserModifyPage({super.key, required this.candidato, required this.pwd});

  @override
  State<UserModifyPage> createState() => _UserModifyState(this.candidato, pwd);
}

class _UserModifyState extends State<UserModifyPage> {
  final _formKey = GlobalKey<FormState>();
  Candidato candidato = Candidato();
  String pwd = "";

  _UserModifyState(this.candidato, this.pwd);

  String password = "";
  bool isLoading = false;
  List<String> listaTiposDocumentosIdentificacion = <String>['CC', 'CE'];
  Map<int, bool?> habilidadesSeleccionadas = {};
  List<Habilidad> listaHabilidades = [];
  List<int> listaHabilidadesCandidato = [];

  Future listarHabilidades() async {
    if (listaHabilidades.length == 0) {
      var listaHabilidadesRetornadas = await CandidatoServices().listarHabilidades();
      listaHabilidades = listaHabilidadesRetornadas.$2!;
      var listaHabilidadesCandidatoRetornadas = await CandidatoServices().listarHabilidadesCandidato(candidato!.id!);
      listaHabilidadesCandidato = listaHabilidadesCandidatoRetornadas.$2!;
      try {
        for (var habilidad in listaHabilidades) {
          habilidadesSeleccionadas[habilidad.id!] =
              listaHabilidadesCandidato.contains(habilidad.id);
        }
      } catch (ex){
        print(ex);
      }
    }
    return listaHabilidades;
  }


  modificarCandidato() async {
    try {
      isLoading = true;
      var valid = _formKey.currentState!.validate();
      if (!valid) {
        isLoading = false;
        return;
      } else {
        var (status, candidatoRespuesta) = await CandidatoServices()
            .modificarCandidato(candidato, this.pwd);
        switch (status) {
          case ServiceStatus.Ok:
            var statusHabilidadesLimpiadas = await CandidatoServices()
                .limpiarHabilidadesCandidato(candidato!.id!);

            List<int> listadoHabilidadesSeleccionadas = [];
            habilidadesSeleccionadas.forEach((key, value) {
              listadoHabilidadesSeleccionadas.add(key);
            });
            var statusHabilidades = await CandidatoServices()
                .guardarHabilidadesCandidato(
                candidato!.id!, listadoHabilidadesSeleccionadas as List<int>);

            Toast.show(AppLocalizations.of(context)!.candidateModifyOkMessage,
                duration: 3, gravity: Toast.center);
            break;
          case ServiceStatus.ServiceError:
            Toast.show(
                AppLocalizations.of(context)!.serviceResponseError, duration: 6,
                gravity: Toast.center);
            break;
          case ServiceStatus.NotFound:
            Toast.show(
                AppLocalizations.of(context)!.candidateModifyErrorMessage,
                duration: 6, gravity: Toast.center);
            break;
        }
        isLoading = false;
      }
    } catch (ex){
      print(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      drawer: Drawer(
        child:Container(
          color: Colors.white,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset("assets/images/foto.png"),
                      SizedBox(height: 10,),
                      Text("${candidato.nombres} ${candidato.apellidos}"),
                    ],
                  )
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.drawerModifyProfile),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserModifyPage(candidato: candidato, pwd: pwd)));
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.drawerAssignedTests),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AssignedTestsPage(candidato: candidato, pwd: pwd)));
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
            child: Text(AppLocalizations.of(context)!.appTitle,
                style: TextStyle(
                    color: Colors.white
                )
            )
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout,),
            tooltip: AppLocalizations.of(context)!.login,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage()
                ),
              );
            },
          ),
        ],
      ),
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
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                        key: Key("_nombres"),
                        onChanged: (value) {
                          candidato.nombres = value;
                        },
                        initialValue: candidato.nombres,
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
                        initialValue: candidato.apellidos,
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
                      initialSelection: candidato.tipoDocumento,
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
                        initialValue: candidato.numDocumento?.round().toString(),
                        validator: (value) => validarNumero(context, int.parse(value!), 1, 999999999999),
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
                        initialValue: candidato.celular,
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
                        initialValue: candidato.email,
                        validator: (value) => validarEmail(context, value),
                        decoration: InputDecoration(
                          label: RequiredLabel(
                              AppLocalizations.of(context)!.email),
                          suffixIcon: const Icon(Icons.cancel_outlined),
                        )),
                  ),
                  SizedBox(height: 20),
                  SizedBox(width: 300,
                    child: Card(
                      color: Colors.white,
                      child: FutureBuilder(
                          future: listarHabilidades(),
                          builder:(context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return // ement-1
                                ListView.builder( //Element-5
                                  shrinkWrap: true,
                                  //this property is must when you put List/Grid View inside SingleChildScrollView
                                  physics: NeverScrollableScrollPhysics(),
                                  //this property is must when you put List/Grid View inside SingleChildScrollView
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, i) {
                                    return CheckboxListTile(
                                      title: Text(snapshot.data[i].habilidad),
                                      value: habilidadesSeleccionadas[i] == true,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          habilidadesSeleccionadas[i] = value;
                                        });
                                      },
                                    );
                                  },
                                );
                            }
                          }
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                        key: Key("_btnRegistrarCandidato"),
                        onPressed: () {
                          modificarCandidato();
                        },
                        child: isLoading? SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(),
                        ) : Text(AppLocalizations.of(context)!.candidateModifySave,
                            style: TextStyle(fontSize: 20))),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

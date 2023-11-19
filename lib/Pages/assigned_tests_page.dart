import 'package:abcjobs_movil/Models/prueba_agendada.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

import '../BackendServices/candidato_services.dart';
import '../Models/candidato.dart';
import '../Utils/utils.dart';
import '../Utils/validaciones.dart';
import 'login_page.dart';

class AssignedTestsPage extends StatefulWidget {
  Candidato candidato;

  AssignedTestsPage({super.key, required this.candidato});

  @override
  State<AssignedTestsPage> createState() => _AssignedTestsPageState(this.candidato);
}

class _AssignedTestsPageState extends State<AssignedTestsPage> {
  final _formKey = GlobalKey<FormState>();
  Candidato candidato;
  _AssignedTestsPageState(this.candidato);
  List<PruebaAgendada> testsList = <PruebaAgendada>[];
  bool isLoading = false;

  Future _cargarListaPruebasAsignadas() async {
    isLoading = true;
    var listaPruebas = await CandidatoServices().listarPruebasAsignadas(candidato!.id ?? 0);
    return listaPruebas.$2;
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
          child: Text(AppLocalizations.of(context)!.appTitle,
            style: TextStyle(
                color: Colors.white
            )
          )
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: AppLocalizations.of(context)!.appTitle,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.appTitle)));
          },
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
            image: AssetImage("assets/images/backgroundinterno.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView( //add to Scroll whole screen
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Text(
                  AppLocalizations.of(context)!.testListTitle,
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ), //E
            ),// l
            FutureBuilder(
            future: _cargarListaPruebasAsignadas(),
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
                      return Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                  Icons.calendar_month, color: Colors.black),
                              title: Text(snapshot.data[i].fecha ?? "",
                                  style: TextStyle(color: Colors.black)),
                              subtitle: Text(snapshot.data[i].nombrePrueba ?? "",
                                  style: TextStyle(color: Colors.black)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: Text(snapshot.data[i].estado == "Agendada"
                                      ? AppLocalizations.of(context)!
                                      .testListGotoTest
                                      : "",
                                    style: TextStyle(color: Colors.blue),),
                                  onPressed: () {
                                    /* ... */
                                  },
                                ),
                                const SizedBox(width: 8),
                                Text(AppLocalizations.of(context)!
                                    .testListGotoStatus + ": " +
                                    (snapshot.data[i]!.estado ?? ""),
                                    style: TextStyle(color: Colors.black)),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
              }
            }
            ),
          ],
        ),
        ),
      ),
    );
  }
}

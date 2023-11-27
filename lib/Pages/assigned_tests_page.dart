import 'package:abcjobs_movil/Models/prueba_agendada.dart';
import 'package:abcjobs_movil/Pages/user_modify_page.dart';
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
  String pwd;
  AssignedTestsPage({super.key, required this.candidato, required this.pwd});

  @override
  State<AssignedTestsPage> createState() => _AssignedTestsPageState(this.candidato, this.pwd);
}

class _AssignedTestsPageState extends State<AssignedTestsPage> {
  final _formKey = GlobalKey<FormState>();
  Candidato candidato;
  String pwd;
  _AssignedTestsPageState(this.candidato, this.pwd);
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

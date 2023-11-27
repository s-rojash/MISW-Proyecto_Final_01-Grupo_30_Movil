import 'package:abcjobs_movil/Pages/assigned_tests_page.dart';
import 'package:abcjobs_movil/Pages/user_modify_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

import '../BackendServices/candidato_services.dart';
import '../Utils/utils.dart';
import '../Utils/validaciones.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  String resultMessage = "";

  autenticarCandidato() async {
    var valid = _formKey.currentState!.validate();
    if (!valid) {
      return;
    } else {
      var (status, candidato) = await CandidatoServices().authenticarCandidato(email, password);
      switch(status){
        case ServiceStatus.Ok:
          setState(() => resultMessage = AppLocalizations.of(context)!.loginOkMessage);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AssignedTestsPage(candidato: candidato!, pwd: password)));
          break;
        case ServiceStatus.ServiceError:
          setState(() => resultMessage = AppLocalizations.of(context)!.serviceResponseError);
          break;
        case ServiceStatus.NotFound:
          setState(() => resultMessage = AppLocalizations.of(context)!.loginErrorMessage);
          break;
      }
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
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.png'),
                SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                      key: Key("_email"),
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) => validarEmail(context, value),
                      decoration: InputDecoration(
                    label: RequiredLabel(AppLocalizations.of(context)!.email),
                    suffixIcon: const Icon(Icons.cancel_outlined),
                  )),
                ),
                SizedBox(height: 40),
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
                SizedBox(
                    height: 40,
                    width: 300,
                    child: Center(
                        child: Text(
                            resultMessage,
                            style: TextStyle(fontSize: 16, color: Colors.white))
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                      key: Key("_btnAutenticarCandidato"),
                      style: ElevatedButton.styleFrom(
                        primary: HexColor("95CCFF"), // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async {
                        await autenticarCandidato();
                      },
                      child: Text(AppLocalizations.of(context)!.login,
                          style: TextStyle(fontSize: 20))),
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                      key: Key("_btnIrARegistrarCandidato"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
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

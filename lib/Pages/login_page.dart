import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

import '../BackendServices/candidato_services.dart';
import '../Utils/utils.dart';
import '../Utils/validaciones.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';

  autenticarCandidato() async {
    var valid = _formKey.currentState!.validate();
    if (!valid) {
      return;
    } else {
      var (status, candidato) = await CandidatoServices().authenticarCandidato(email, password);
      switch(status){
        case ServiceStatus.Ok:
          Toast.show(AppLocalizations.of(context)!.loginOkMessage, duration: 6, gravity: Toast.center);
          break;
        case ServiceStatus.ServiceError:
          Toast.show(AppLocalizations.of(context)!.serviceResponseError, duration: 6, gravity: Toast.center);
          break;
        case ServiceStatus.NotFound:
          Toast.show(AppLocalizations.of(context)!.loginErrorMessage, duration: 6, gravity: Toast.center);
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
                SizedBox(height: 50),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
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

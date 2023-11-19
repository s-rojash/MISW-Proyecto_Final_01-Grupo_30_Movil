import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

import '../BackendServices/candidato_services.dart';
import '../Utils/utils.dart';
import '../Utils/validaciones.dart';
import 'register_page.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key, required this.title});
  final String title;

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  final _formKey = GlobalKey<FormState>();
  String resultMessage = "";

  cerrarSesion() async {

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
                SizedBox(height: 100),
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
                        await cerrarSesion();
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

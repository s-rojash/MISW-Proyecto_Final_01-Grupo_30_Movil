import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Utils/Utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.png'),
              SizedBox(height: 30),
              SizedBox(width: 300,
                child: TextFormField(
                    decoration: InputDecoration(
                      label: RequiredLabel( AppLocalizations.of(context)!.email),
                      suffixIcon: const Icon(Icons.cancel_outlined),
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
                    )
                ),
              ),
              SizedBox(height: 40),
              SizedBox(width: 300,
                child: TextFormField(
                    decoration: InputDecoration(
                      label: RequiredLabel( AppLocalizations.of(context)!.password),
                      suffixIcon: const Icon(Icons.cancel_outlined),
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
                    )
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                height: 40,
                width: 300,
                child:
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("95CCFF"), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      //Navigator.push(
                      //  context,
                      //MaterialPageRoute(builder: (context) => const AutenticacionPage()),
                      //);
                    },
                    child: Text(AppLocalizations.of(context)!.login, style: TextStyle(
                      fontSize: 20))
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(onPressed: () {},
                        child: Text(AppLocalizations.of(context)!.register, style: TextStyle(
                            fontSize: 20)
                        )
                    ),
                  ),
          ],
        ),
        ),
      ),
    );
  }
}

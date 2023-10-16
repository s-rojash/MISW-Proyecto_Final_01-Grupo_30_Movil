import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:email_validator/email_validator.dart';

validarTexto(BuildContext context, String? valor) {
  if (valor!.isEmpty) {
    return AppLocalizations.of(context)!.fieldRequired;
  } else {
    return null;
  }
}

validarEmail(BuildContext context, String? valor) {
  if (valor!.isEmpty) {
    return AppLocalizations.of(context)!.fieldRequired;
  } else {
    if (!EmailValidator.validate(valor)){
      return AppLocalizations.of(context)!.invalidEmail;
    } else {
      return null;
    }
  }
}

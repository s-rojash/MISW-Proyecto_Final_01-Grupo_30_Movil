import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:email_validator/email_validator.dart';

validarTexto(BuildContext context, String? valor, int? longitudMinima, int? longitudMaxima) {
  try {
    if (valor!.isEmpty) {
      return AppLocalizations.of(context)!.fieldRequired;
    } else {
      longitudMinima ??= 0;
      longitudMaxima ??= 20000;
      if (valor.length < longitudMinima) {
        return AppLocalizations.of(context)!.fieldMinimumLengthError + " " + longitudMinima.toString();
      } else if (valor.length > longitudMaxima) {
        return AppLocalizations.of(context)!.fieldMaximumLengthError + " " + longitudMaxima.toString();
      }
      return null;
    }
  } catch (ex){
    print(ex);
    return null;
  }
}

validarNumero(BuildContext context, int? valor, int? valorMinimo, int? valorMaximo) {
  try{
  if (valor == null) {
    return AppLocalizations.of(context)!.fieldRequired;
  } else {
    valorMinimo ??= double.minPositive as int;
    valorMaximo ??= double.maxFinite as int;
    if (valor < valorMinimo){
      return AppLocalizations.of(context)!.fieldMinimumValueError + " " + valorMinimo.toString();
    } else if (valor > valorMaximo){
      return AppLocalizations.of(context)!.fieldMaximumValueError + " " + valorMaximo.toString();
    }
    return null;
  }
  } catch (ex){
    print(ex);
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

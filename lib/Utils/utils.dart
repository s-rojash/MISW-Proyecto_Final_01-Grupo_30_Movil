import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class RequiredLabel extends StatelessWidget {
  final String label;

  const RequiredLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text('* ',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        Text('   ' + label,),
      ],
    );
  }
}

class ServiceResponse {
  static ServiceStatus GetStatus(int statusCode) {
    switch (statusCode) {
      case 200:
        return ServiceStatus.Ok;
      case 500:
        return ServiceStatus.ServiceError;
      case 404:
        return ServiceStatus.NotFound;
      default:
        return ServiceStatus.ServiceError;
    }
  }
}


enum ServiceStatus{
  Ok,
  ServiceError,
  NotFound
}
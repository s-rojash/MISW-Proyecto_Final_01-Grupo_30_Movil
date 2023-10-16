# MISW-Proyecto_Final_01-Grupo_30_Movil



## Localización

Se instalaron los paquetes y librerías establecidos en

```https://docs.flutter.dev/ui/accessibility-and-localization/internationalization```


# Pruebas
## Pruebas unitarias
Se implementaron con flutter_test

Se pueden correr con el comando

```flutter test --coverage```

Las pruebas unitarias están ubicadas dentro de la carpeta /test y solo se aplican aquellas cuyo nombre de archivo termina en "_test.dart"

Las pruebas ya generan la cobertura en /coverage/lcov.info, para exportar a HTML se usa lcov en windows o genhtml en linux

```perl %GENHTML% -o coverage\html coverage\lcov.info```

![image](https://github.com/s-rojash/MISW-Proyecto_Final_01-Grupo_30_Movil/assets/98789252/0096456a-6002-44d0-a0c7-f1e06387f95c)


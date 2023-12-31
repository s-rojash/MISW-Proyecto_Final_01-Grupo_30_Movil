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

En windows, es posible que el script de conversión no esté disponible como variable de entorno, en ese caso se puede ejecutar directamente así:

```perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml -o coverage\html coverage\lcov.info```
=======
## Pruebas automáticas

Las pruebas unitarias se realizan con flutter_test y se encuentran en la carpeta /test

El siguiente comando corre todas las pruebas unitarias incluidas en /test y cuyo nombre de archivo termine en "_test.dart"

```flutter test```

las pruebas E2E (llamadas pruebas de integración en flutter) se realizan con ìntegration_test y se encuentran en la carpeta /integration_test

El siguiente comando ejecuta las pruebas de E2E que se encuentren en la carpeta /integration_test y cuyo nombre termine en _test.dart

```flutter pub add 'dev:flutter_test:{"sdk":"flutter"}'  'dev:integration_test:{"sdk":"flutter"}'```



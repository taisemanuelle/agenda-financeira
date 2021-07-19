import 'package:agenda_app/screen/InicialPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:splashscreen/splashscreen.dart';


main() {
  initializeDateFormatting().then((_) {
    runApp(MaterialApp(
      home: InicialPage(),
      debugShowCheckedModeBanner: false,
    ));
  });
}

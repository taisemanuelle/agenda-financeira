import 'controller/relatorioController.dart';
import 'controller/transController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constFiles/colors.dart';
import 'controller/transDetalhesController.dart';
import 'view/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RelatorioController()),
        ChangeNotifierProvider(create: (_) => TransController()),
        ChangeNotifierProvider(create: (_) => TransDetalheController()),
      ],
      child: MaterialApp(
        title: 'Agenda Financeira',
        theme: ThemeData(
            primaryColor: primaryColor, scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

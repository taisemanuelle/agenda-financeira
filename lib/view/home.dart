import 'package:agenda_app/constFiles/colors.dart';
import 'package:agenda_app/controller/transDetalhesController.dart';
import 'package:agenda_app/view/transDetalhe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homeScreen.dart';
import 'telaVerMais.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransDetalheController transDetalheController =
        Provider.of<TransDetalheController>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton.icon(
                label: Text('Home'),
                icon: Icon(Icons.home),
                onPressed: () {
                  if (!transDetalheController.buttonSelected)
                    transDetalheController.changeHomeNdReportSection(true);
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                ),
              ),
              SizedBox(width: 10.0),
              TextButton.icon(
                label: Text('Ver Mais'),
                icon: Icon(Icons.bar_chart),
                onPressed: () {
                  if (transDetalheController.buttonSelected)
                    transDetalheController.changeHomeNdReportSection(false);
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          transDetalheController.toTransDetalhes(isSaved: false);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => TransDetalhe()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
          child: transDetalheController.buttonSelected
              ? HomeScreen()
              : telaVerMais(),
        ),
      ),
    );
  }
}

telaVerMais() {}

import 'package:agenda_app/componentes/recenteTransLista.dart';
import 'package:agenda_app/componentes/homeRelatorioContainer.dart';
import 'package:agenda_app/componentes/appBar.dart';
import 'package:agenda_app/constFiles/colors.dart';
import 'package:agenda_app/controller/transController.dart';
import 'package:agenda_app/controller/transDetalhesController.dart';
import 'package:agenda_app/customWidgets/textButton.dart';
import 'package:agenda_app/view/transactionList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransController transController = Provider.of<TransController>(context);
    TransDetalheController transDetalhesController =
        Provider.of<TransDetalheController>(context);

    return transController.fetching
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              BarApp(),
              HomeReportContainer(transactionController: transController),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 4,
                      child: Text("Movimentações Recentes",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Expanded(
                    child: CustomTextButton(
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => TransLista())),
                      textStyle: TextStyle(
                          color: selectedTextButton,
                          fontWeight: FontWeight.bold),
                      text: 'Ver Tudo',
                    ),
                  )
                ],
              ),
              RecenteTransList(
                  transController: transController,
                  transDetalheController: transDetalhesController),
            ],
          );
  }
}

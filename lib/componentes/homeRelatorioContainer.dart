import 'package:auto_size_text/auto_size_text.dart';
import 'package:agenda_app/constFiles/colors.dart';
import 'package:agenda_app/constFiles/strings.dart';
import 'package:agenda_app/controller/transController.dart';
import 'package:flutter/material.dart';

class HomeReportContainer extends StatelessWidget {
  const HomeReportContainer({
    Key? key,
    required this.transactionController,
  }) : super(key: key);

  final TransController transactionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.85),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Total ",
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("R\$",
                  style: TextStyle(
                      color: whiteColor, fontWeight: FontWeight.bold)),
              Expanded(
                child: AutoSizeText(
                    transactionController.total.toStringAsFixed(1),
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    textAlign: TextAlign.center),
              ),
            ],
          ),
          IncomeExpense(transactionController: transactionController),
        ]
            .map((e) => Padding(padding: EdgeInsets.only(top: 15.0), child: e))
            .toList(),
      ),
    );
  }
}

class IncomeExpense extends StatelessWidget {
  const IncomeExpense({
    Key? key,
    required this.transactionController,
  }) : super(key: key);

  final TransController transactionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_upward, color: receitaGreen),
                    Text(receita, style: TextStyle(color: whiteColor)),
                  ],
                ),
                Center(
                  child: AutoSizeText(
                    transactionController.totalReceita.toStringAsFixed(1),
                    style: TextStyle(color: whiteColor, fontSize: 20),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            color: whiteColor,
            width: 2,
            height: 50.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_downward, color: despesaRed),
                    Text(despesa, style: TextStyle(color: whiteColor)),
                  ],
                ),
                Center(
                  child: AutoSizeText(
                    transactionController.totalDespesa.toStringAsFixed(1),
                    style: TextStyle(color: whiteColor, fontSize: 20),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:agenda_app/constFiles/strings.dart';
import 'package:agenda_app/modelo/TransacaoModelo.dart';
import 'package:agenda_app/services/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RelatorioController with ChangeNotifier {
  DatabaseHelper? databaseHelper = DatabaseHelper.instance;
  RelatorioController() {
    if (databaseHelper != null) buscaTransacao();
  }

  String reportMethod = receita;

  List<TransacaoModelo?> transLista = [];
  List<TransacaoModelo?> transReceitaLista = [];
  List<TransacaoModelo?> transDespesaLista = [];

  double total = 0.0;
  double totalReceita = 0.0;
  double totalDespesa = 0.0;
  double saudeReceita = 0.0;
  double saudeDespesa = 0.0;
  double casaReceita = 0.0;
  double casaDespesa = 0.0;
  double alimentacaoReceita = 0.0;
  double alimentacaoDespesa = 0.0;
  double salarioReceita = 0.0;
  double salarioDespesa = 0.0;
  double outrosReceita = 0.0;
  double outrosDespesa = 0.0;

  void cartButton(String value) {
    reportMethod = value;
    notifyListeners();
  }

  void buscaTransacao(
      {DateTime? customFromDate, DateTime? customToDate}) async {
    DateTime fromDate = customFromDate ?? DateTime.now();
    DateTime toDate = customFromDate ?? DateTime.now();

    transLista = [];

    String dia = 'd';
    String mes = 'M';

    String doDia = 'd';
    String doMes = 'M';

    //date formatting
    //if date is less than 10, then add 0
    if (fromDate.day < 10) dia = '0d';
    if (fromDate.month < 10) mes = '0M';
    if (toDate.day < 10) mes = '0d';
    if (toDate.month < 10) mes = '0M';

    //formatted date string
    String fromDateFormat = "y-$mes-$dia";
    String toDateFormat = "y-$doMes-$doDia";

    final dataList = await databaseHelper!.getDateRangeData(
        transTable,
        DateFormat(fromDateFormat).format(fromDate),
        DateFormat(toDateFormat).format(toDate));

    transLista = dataList.map((e) => TransacaoModelo.fromMap(e)).toList();

    transReceitaLista =
        transLista.where((element) => element!.ehReceita == 1).toList();
    transDespesaLista =
        transLista.where((element) => element!.ehReceita == 0).toList();

    totalReceita = transReceitaLista.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element!.valor ?? "0.0"));

    totalDespesa = transDespesaLista.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element!.valor ?? "0.0"));

    //calculate balance amount
    total = totalReceita - totalDespesa;

    //get each category income and expense amount
    saudeReceita = valorCalc(transReceitaLista, saude);
    saudeDespesa = valorCalc(transDespesaLista, saude);
    casaReceita = valorCalc(transReceitaLista, family);
    casaDespesa = valorCalc(transDespesaLista, family);
    alimentacaoReceita = valorCalc(transReceitaLista, alimentacao);
    alimentacaoDespesa = valorCalc(transDespesaLista, alimentacao);
    salarioReceita = valorCalc(transReceitaLista, salario);
    salarioDespesa = valorCalc(transDespesaLista, salario);
    salarioReceita = valorCalc(transReceitaLista, piggy);
    salarioDespesa = valorCalc(transDespesaLista, piggy);
    outrosReceita = valorCalc(transReceitaLista, outros);
    outrosDespesa = valorCalc(transDespesaLista, outros);
    notifyListeners();
  }

  double valorCalc(
          List<TransacaoModelo?> transReceitaLista, String categoria) =>
      transReceitaLista
          .where((element) => element!.categoria == categoria)
          .fold(
              0,
              (previousValue, element) =>
                  previousValue + double.parse(element!.valor ?? "0.0"));
}

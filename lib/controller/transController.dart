import 'package:agenda_app/constFiles/strings.dart';
import 'package:agenda_app/modelo/TransacaoModelo.dart';

import 'package:agenda_app/services/databaseHelper.dart';
import 'package:flutter/cupertino.dart';

class TransController with ChangeNotifier {
  DatabaseHelper? databaseHelper = DatabaseHelper.instance;

  List<TransacaoModelo?> transLista = [];

  double totalReceita = 0.0;
  double totalDespesa = 0.0;
  double total = 0.0;

  bool fetching = false;

  TransController() {
    if (databaseHelper != null) buscaTransacao();
  }

  void buscaTransacao() async {
    fetching = true;
    transLista = [];
    totalReceita = 0.0;
    totalDespesa = 0.0;
    total = 0.0;

    final dataList = await databaseHelper!.getData(transTable);

    transLista = dataList.map((e) => TransacaoModelo.fromMap(e)).toList();

    transLista.forEach((element) {
      if (element!.ehReceita == 1) {
        totalReceita += double.parse(element.valor ?? "0.0");
      } else {
        totalDespesa += double.parse(element.valor ?? "0.0");
      }
    });
    total = totalReceita - totalDespesa;

    fetching = false;

    notifyListeners();
  }

  void inserirTransacao(TransacaoModelo transacaoModelo) async =>
      await databaseHelper!
          .inserirData(transTable, transacaoModelo.transactionToMap())
          .catchError((onError) => print("Inserir: $onError"));

  void atualizaTransacao(TransacaoModelo transacaoModelo) async =>
      await databaseHelper!
          .atualizarData(transTable, transacaoModelo.transactionToMap(),
              transacaoModelo.id ?? 0)
          .catchError((onError) => print("Atualizar: $onError"));

  void deletarTransacao(int id) async => await databaseHelper!
      .deletarData(transTable, id)
      .catchError((onError) => print("Deletar: $onError"));

  String tituloDoIcons(String nome) {
    if (nome == saude) return svgPath(saudeSvg);
    if (nome == family) return svgPath(familySvg);

    if (nome == alimentacao) return svgPath(alimentacaoSvg);

    if (nome == salario) return svgPath(salarioSvg);

    if (nome == piggy) return svgPath(piggySvg);
    return svgPath(othersSvg);
  }
}

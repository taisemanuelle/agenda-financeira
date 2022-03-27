import 'package:agenda_app/constFiles/strings.dart';
import 'package:agenda_app/services/databaseHelper.dart';
import 'package:flutter/cupertino.dart';

class TransDetalheController with ChangeNotifier {
  DatabaseHelper? databaseHelper = DatabaseHelper.instance;

  bool ehReceitaSelecionar = false;
  bool salvarTrans = false;

  String selecionarCategoria = outros;

  int? transId;
  String? data;

  bool buttonSelected = true;

  get titulo => null;

  get valor => null;

  get anotacao => null;

  void changeHomeNdReportSection(bool value) {
    buttonSelected = value;
    notifyListeners();
  }

  void changeCategory() {
    ehReceitaSelecionar = !ehReceitaSelecionar;
    notifyListeners();
  }

  void changeDepartment(String nome) {
    selecionarCategoria = nome;
    notifyListeners();
  }

  String titleIcon() {
    if (selecionarCategoria == saude) return svgPath(saudeSvg);
    if (selecionarCategoria == family) return svgPath(familySvg);

    if (selecionarCategoria == alimentacao) return svgPath(alimentacaoSvg);

    if (selecionarCategoria == salario) return svgPath(salarioSvg);

    if (selecionarCategoria == piggy) return svgPath(piggySvg);
    return svgPath(othersSvg);
  }

  void toTransDetalhes({
    required bool isSaved,
    int? id,
    String? titulo,
    String? anotacao,
    String? valor,
    bool? ehReceita,
    String? categoria,
    String? dateTime,
  }) {
    salvarTrans = isSaved;
    transId = id;
    //titulo.text = titulo ?? "";
    //anotacao.text = anotacao ?? "";
    //valor.text = valor ?? "";
    ehReceitaSelecionar = ehReceita ?? false;
    selecionarCategoria = categoria ?? outros;
    data = dateTime ?? DateTime.now().toString();
    notifyListeners();
  }

  static textEditarController() async {}
}

class TextEditarController {}

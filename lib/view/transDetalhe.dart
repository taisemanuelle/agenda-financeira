import 'package:agenda_app/constFiles/colors.dart';
import 'package:agenda_app/constFiles/strings.dart';
import 'package:agenda_app/controller/relatorioController.dart';
import 'package:agenda_app/controller/transDetalhesController.dart';
import 'package:agenda_app/controller/transController.dart';
import 'package:agenda_app/customWidgets/snackbar.dart';
import 'package:agenda_app/modelo/TransacaoModelo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TransDetalhe extends StatelessWidget {
  TransDetalhe({Key? key}) : super(key: key);
  static TransDetalheController? transDetalheController;
  static TransController? transController;
  static RelatorioController? relatorioController;

  @override
  Widget build(BuildContext context) {
    transDetalheController = Provider.of<TransDetalheController>(context);
    transController = Provider.of<TransController>(context);
    relatorioController = Provider.of<RelatorioController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        leadingWidth: 25.0,
        title: Row(
          children: [
            Text(
              transDetalheController!.ehReceitaSelecionar ? receita : despesa,
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
            ),
            IconButton(
                icon: Icon(Icons.arrow_drop_down_circle),
                tooltip: "Mudar a categoria",
                onPressed: () => transDetalheController!.changeCategory())
          ],
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: TextButton(
                    onPressed: () => save(context),
                    child: Text(
                        transDetalheController!.salvarTrans
                            ? "Atualizar"
                            : "Salvar",
                        style: TextStyle(color: whiteColor))),
              ),
            ],
          )
        ],
        iconTheme: IconThemeData(color: blackColor),
      ),
      body: Column(
        children: [
          GridView(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1.4),
            children: [
              categoriaIcons(
                  text: saude,
                  svgName: saudeSvg,
                  isSelected:
                      transDetalheController!.selecionarCategoria == saude
                          ? true
                          : false,
                  onPress: () =>
                      transDetalheController!.changeDepartment(saude)),
              categoriaIcons(
                  text: family,
                  svgName: familySvg,
                  isSelected:
                      transDetalheController!.selecionarCategoria == family
                          ? true
                          : false,
                  onPress: () =>
                      transDetalheController!.changeDepartment(family)),
              categoriaIcons(
                  text: alimentacao,
                  svgName: alimentacaoSvg,
                  isSelected:
                      transDetalheController!.selecionarCategoria == alimentacao
                          ? true
                          : false,
                  onPress: () =>
                      transDetalheController!.changeDepartment(alimentacao)),
              categoriaIcons(
                  text: salario,
                  svgName: salarioSvg,
                  isSelected:
                      transDetalheController!.selecionarCategoria == salario
                          ? true
                          : false,
                  onPress: () =>
                      transDetalheController!.changeDepartment(salario)),
              categoriaIcons(
                  text: piggy,
                  svgName: piggySvg,
                  isSelected:
                      transDetalheController!.selecionarCategoria == piggy
                          ? true
                          : false,
                  onPress: () =>
                      transDetalheController!.changeDepartment(piggy)),
              categoriaIcons(
                  text: outros,
                  svgName: othersSvg,
                  isSelected:
                      transDetalheController!.selecionarCategoria == outros
                          ? true
                          : false,
                  onPress: () =>
                      transDetalheController!.changeDepartment(outros)),
            ],
          ),
          Container(
            color: primaryColor,
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: TextField(
                      controller: transDetalheController!.titulo,
                      cursorColor: greyText,
                      style: TextStyle(
                          color: greyText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          hintText: "Titulo",
                          hintStyle: TextStyle(color: greyText),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, left: 5.0),
                            child: SvgPicture.asset(
                              transDetalheController!.titleIcon(),
                              height: 4.0,
                              color: whiteColor,
                            ),
                          ),
                          border: InputBorder.none),
                    )),
                Spacer(),
                Expanded(
                    child: TextField(
                  controller: transDetalheController!.valor,
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  cursorColor: greyText,
                  style: TextStyle(
                      color: greyText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      hintText: "Valor",
                      hintStyle: TextStyle(color: greyText),
                      border: InputBorder.none),
                )),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: transDetalheController!.anotacao,
                textAlign: TextAlign.start,
                minLines: 10,
                maxLines: 20,
                decoration: InputDecoration(
                    hintText: "Anotações...", border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding categoriaIcons({
    required String text,
    required String svgName,
    required bool isSelected,
    required Function() onPress,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: isSelected ? Color(0xffeae1f9) : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Column(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  svgPath(svgName),
                  height: 35.0,
                  color: svgColor,
                ),
              ),
              Text(
                text,
                style: TextStyle(color: svgColor, fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  save(BuildContext context) {
    if (transDetalheController!.titulo.text.isEmpty) {
      snackBar(context: context, title: "Título é obrigatório");
    } else if (double.tryParse(transDetalheController!.valor.text) == null ||
        transDetalheController!.valor.text.contains("-")) {
      snackBar(context: context, title: "Insira um valor válido.");
    } else {
      TransacaoModelo transacaoModelo = TransacaoModelo(
        id: transDetalheController!.salvarTrans
            ? transDetalheController!.transId
            : DateTime.now().microsecondsSinceEpoch,
        titulo: transDetalheController!.titulo.text,
        anotacao: transDetalheController!.anotacao.text,
        valor: transDetalheController!.valor.text,
        ehReceita: transDetalheController!.ehReceitaSelecionar ? 1 : 0,
        categoria: transDetalheController!.selecionarCategoria,
        dateTime: transDetalheController!.salvarTrans
            ? transDetalheController!.data
            : DateTime.now().toString(),
      );

      if (transDetalheController!.salvarTrans) {
        transController!.atualizaTransacao(transacaoModelo);
      } else {
        transController!.inserirTransacao(transacaoModelo);
      }
      transController!.buscaTransacao();
      relatorioController!.buscaTransacao();
      Navigator.pop(context);
    }
  }
}

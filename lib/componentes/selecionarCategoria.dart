import 'package:agenda_app/constFiles/colors.dart';
import 'package:agenda_app/constFiles/strings.dart';
import 'package:agenda_app/controller/relatorioController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'seletorDeCategoria.dart';

class SelecionarCategoria extends StatelessWidget {
  const SelecionarCategoria(
      {Key? key,
      relatorioController,
      required Color textColor,
      Color? containerColor,
      String? text,
      required void Function() onPress})
      : super(key: key);

  static RelatorioController? relatorioController;

  @override
  Widget build(BuildContext context) {
    relatorioController = Provider.of<RelatorioController>(context);
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: tabContainer,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Row(
        children: [
          SelecionarCategoria(
              relatorioController: relatorioController!,
              text: tudo,
              containerColor: containerColor(tudo),
              textColor: categoriaTextColor(tudo),
              onPress: () => relatorioController!.cartButton(tudo)),
          SelecionarCategoria(
              relatorioController: relatorioController!,
              text: receita,
              containerColor: containerColor(receita),
              textColor: categoriaTextColor(receita),
              onPress: () => relatorioController!.cartButton(receita)),
          SelecionarCategoria(
              relatorioController: relatorioController!,
              text: despesa,
              containerColor: containerColor(despesa),
              textColor: categoriaTextColor(despesa),
              onPress: () => relatorioController!.cartButton(despesa)),
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: new DateTime(2015),
                    lastDate: new DateTime(DateTime.now().year + 10));
                if (picked != null)
                  relatorioController!.buscaTransacao(
                      customFromDate: picked.start, customToDate: picked.end);
              })
        ],
      ),
    );
  }

  Color containerColor(String method) =>
      relatorioController!.reportMethod == method
          ? primaryColor
          : Colors.transparent;

  Color categoriaTextColor(String method) =>
      relatorioController!.reportMethod == method ? whiteColor : categoriaText;
}

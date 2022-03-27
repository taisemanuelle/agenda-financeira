import 'package:agenda_app/constFiles/colors.dart';
import 'package:agenda_app/constFiles/dateConvert.dart';
import 'package:agenda_app/constFiles/strings.dart';
import 'package:agenda_app/controller/relatorioController.dart';
import 'package:agenda_app/controller/transController.dart';
import 'package:agenda_app/controller/transDetalhesController.dart';
import 'package:agenda_app/modelo/TransacaoModelo.dart';
import 'package:agenda_app/view/transDetalhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TransLista extends StatelessWidget {
  const TransLista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransController transController = Provider.of<TransController>(context);
    TransDetalheController transactionDetailController =
        Provider.of<TransDetalheController>(context);
    RelatorioController relatorioController =
        Provider.of<RelatorioController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda Financeira", style: TextStyle(color: whiteColor)),
        centerTitle: true,
        backwardsCompatibility: true,
        backgroundColor: primaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: whiteColor),
      ),
      body: transController.transLista.length == 0
          ? Center(child: Text("Sem movimentações"))
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: transController.transLista.length,
              itemBuilder: (BuildContext context, int index) {
                TransacaoModelo? data = transController.transLista[index];

                String valores = data!.ehReceita == 1 ? "+" : "-";
                Color valorColor =
                    data.ehReceita == 1 ? receitaGreen : despesaRed;

                return ListTile(
                  onTap: () {
                    transactionDetailController.toTransDetalhes(
                        isSaved: true,
                        id: data.id,
                        titulo: data.titulo,
                        anotacao: data.anotacao,
                        valor: data.valor,
                        categoria: data.categoria,
                        ehReceita: data.ehReceita == 1 ? true : false,
                        dateTime: data.dateTime);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => TransDetalhe()));
                  },
                  title: Text(data.titulo ?? ""),
                  contentPadding: EdgeInsets.all(5.0),
                  leading: Container(
                    height: 50.0,
                    width: 50.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: [BoxShadow(color: blackColor)],
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: SvgPicture.asset(
                      transController.tituloDoIcons(data.categoria ?? outros),
                      height: 35.0,
                      color: svgColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dateConverter(DateTime.parse(
                          data.dateTime ?? "2000-01-1 00:00:00.000"))),
                      Text(
                        "$valores${data.valor}",
                        style: TextStyle(color: valorColor),
                      )
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      transController.deletarTransacao(data.id ?? 0);
                      transController.buscaTransacao();
                      relatorioController.buscaTransacao();
                    },
                    icon: Icon(Icons.delete_outline, color: svgColor),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
    );
  }
}

import 'package:agenda_app/constFiles/colors.dart';
import 'package:agenda_app/constFiles/dateConvert.dart';
import 'package:agenda_app/constFiles/strings.dart';
import 'package:agenda_app/controller/transDetalhesController.dart';
import 'package:agenda_app/controller/transController.dart';
import 'package:agenda_app/modelo/TransacaoModelo.dart';
import 'package:agenda_app/view/transDetalhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecenteTransList extends StatelessWidget {
  const RecenteTransList({
    Key? key,
    required this.transController,
    required this.transDetalheController,
  }) : super(key: key);

  final TransController transController;
  final TransDetalheController transDetalheController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transController.transLista.length == 0
          ? Center(child: Text("Sem movimentações"))
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                if (transController.transLista.length > index) {
                  TransacaoModelo? data = transController.transLista[index];

                  String valores = data!.ehReceita == 1 ? "+" : "-";
                  Color amountColor =
                      data.ehReceita == 1 ? receitaGreen : despesaRed;

                  return ListTile(
                    onTap: () {
                      transDetalheController.toTransDetalhes(
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
                            builder: (BuildContext context) => TransDetalhe()),
                      );
                    },
                    title: Text(data.titulo ?? ""),
                    contentPadding: EdgeInsets.all(10.0),
                    leading: Container(
                      height: 50.0,
                      width: 50.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          boxShadow: [BoxShadow(color: blackColor)],
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: SvgPicture.asset(
                        transController.tituloDoIcons(data.categoria ?? outros),
                        height: 35.0,
                        color: svgColor,
                      ),
                    ),
                    subtitle: Text(dateConverter(DateTime.parse(
                        data.dateTime ?? "2000-01-1 00:00:00.000"))),
                    trailing: Text(
                      "$valores${data.valor}",
                      style: TextStyle(color: amountColor),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
    );
  }
}

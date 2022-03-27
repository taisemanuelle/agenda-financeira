import 'package:agenda_app/componentes/selecionarCategoria.dart';
import 'package:agenda_app/constFiles/colors.dart';
import 'package:agenda_app/constFiles/strings.dart';
import 'package:agenda_app/controller/relatorioController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class VerMais extends StatelessWidget {
  const VerMais({Key? key}) : super(key: key);
  static RelatorioController? relatorioController;

  @override
  Widget build(BuildContext context) {
    relatorioController = Provider.of<RelatorioController>(context);

    return Column(
      children: [
        selecionaCategoria(),
        if (relatorioController!.reportMethod != tudo)
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: PieChart(
              dataMap: {
                saude: chartValue(relatorioController!.saudeReceita,
                    relatorioController!.saudeDespesa),
                family: chartValue(relatorioController!.casaReceita,
                    relatorioController!.casaReceita),
                alimentacao: chartValue(relatorioController!.alimentacaoReceita,
                    relatorioController!.alimentacaoDespesa),
                salario: chartValue(relatorioController!.salarioReceita,
                    relatorioController!.salarioDespesa),
                piggy: chartValue(relatorioController!.salarioReceita,
                    relatorioController!.salarioDespesa),
                outros: chartValue(relatorioController!.outrosReceita,
                    relatorioController!.outrosDespesa),
              },
              animationDuration: Duration(seconds: 1),
              ringStrokeWidth: 40,
              chartType: ChartType.ring,
              legendOptions: LegendOptions(showLegends: true),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: true,
              ),
            ),
          ),
        if (relatorioController!.reportMethod == tudo)
          Container(
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.85),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: Column(
              children: [
                Text("Total: ${relatorioController!.total.toStringAsFixed(1)}",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: whiteColor)),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "Receitas:\n${relatorioController!.totalReceita.toStringAsFixed(1)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, color: whiteColor)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                          "Despesas:\n${relatorioController!.totalDespesa.toStringAsFixed(1)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, color: whiteColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              tile(
                titulo: "Saúde",
                svgName: saudeSvg,
                valorReceita: relatorioController!.saudeReceita,
                valorDespesa: relatorioController!.saudeDespesa,
              ),
              tile(
                titulo: "Casa",
                svgName: familySvg,
                valorReceita: relatorioController!.casaReceita,
                valorDespesa: relatorioController!.saudeDespesa,
              ),
              tile(
                titulo: "Comida",
                svgName: alimentacaoSvg,
                valorReceita: relatorioController!.alimentacaoReceita,
                valorDespesa: relatorioController!.alimentacaoDespesa,
              ),
              tile(
                titulo: "Salário",
                svgName: salarioSvg,
                valorReceita: relatorioController!.salarioReceita,
                valorDespesa: relatorioController!.salarioDespesa,
              ),
              tile(
                titulo: "Outros",
                svgName: othersSvg,
                valorReceita: relatorioController!.outrosReceita,
                valorDespesa: relatorioController!.outrosDespesa,
              ),
            ],
          ),
        ),
      ],
    );
  }

  ListTile tile({
    required String titulo,
    required String svgName,
    required double valorReceita,
    required double valorDespesa,
  }) {
    double porcentagem = 0;
    String inicio_valor = "0.0";
    if (relatorioController!.reportMethod == receita) {
      porcentagem = valorReceita / relatorioController!.totalReceita * 100;
      if (valorReceita != 0)
        inicio_valor = "+${valorReceita.toStringAsFixed(1)}";
    }

    if (relatorioController!.reportMethod == despesa) {
      porcentagem = valorDespesa / relatorioController!.totalDespesa * 100;
      if (valorDespesa != 0)
        inicio_valor = "-${valorDespesa.toStringAsFixed(1)}";
    }

    if (relatorioController!.reportMethod == tudo) {
      inicio_valor = (valorReceita - valorDespesa).toStringAsFixed(1);
    }

    return ListTile(
      title: Text(titulo),
      contentPadding: EdgeInsets.all(10.0),
      leading: Container(
        height: 50.0,
        width: 50.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [BoxShadow(color: blackColor)],
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: SvgPicture.asset(
          svgPath(svgName),
          height: 35.0,
          color: svgColor,
        ),
      ),
      subtitle: relatorioController!.reportMethod == tudo
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$receita: ${valorReceita.toStringAsFixed(1)}",
                    style: TextStyle(color: receitaGreen)),
                Text("$despesa: ${valorDespesa.toStringAsFixed(1)}",
                    style: TextStyle(color: despesaRed)),
              ],
            )
          : Text(
              "Porcentagem : ${porcentagem > 0 ? porcentagem.toStringAsFixed(1) : 0}%"),
      trailing: Text(inicio_valor,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: relatorioController!.reportMethod == receita
                  ? receitaGreen
                  : relatorioController!.reportMethod == despesa
                      ? despesaRed
                      : blackColor)),
    );
  }

  double chartValue(double valorReceita, double valorDespesa) {
    if (relatorioController!.reportMethod == receita) return valorReceita;
    if (relatorioController!.reportMethod == despesa) return valorDespesa;
    return valorDespesa - valorReceita;
  }

  selecionaCategoria() {}
}

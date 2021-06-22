import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:agenda_app/modelo/despesa.dart';

class GraficoDeBarras extends StatefulWidget {
  final List<Despesa> despesas;

  GraficoDeBarras({this.despesas});

  @override
  State<StatefulWidget> createState() => GraficoDeBarrasState();
}

class GraficoDeBarrasState extends State<GraficoDeBarras> {
  final Color barBackgroundColor = Colors.white;
  int touchedIndex;
  double total;
  List<double> gastos = List.generate(12, (index) => 0);

  double calculateTotal() {
    if (gastos.isNotEmpty) {
      gastos.clear();
      gastos = List.generate(12, (index) => 0);
    }

    if (widget.despesas.isEmpty) {
      return 0;
    }
    double sum = 0;
    for (Despesa despesa in widget.despesas) {
      gastos[despesa.data.month - 1] += despesa.valor;

      sum += despesa.valor;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    calculateTotal();
    total = gastos.reduce(max);
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.green,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'Gastos Mensais',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  height: 38,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BarChart(
                      mainBarData(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? Theme.of(context).primaryColorDark : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: total, // Length of all Bars
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  // Actual Data
  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, gastos[0], isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, gastos[1], isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, gastos[2], isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, gastos[3], isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, gastos[4], isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, gastos[5], isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, gastos[6], isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, gastos[7], isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(8, gastos[8], isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(9, gastos[9], isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(10, gastos[10], isTouched: i == touchedIndex);
          case 11:
            return makeGroupData(11, gastos[11], isTouched: i == touchedIndex);
          case 12:
            return makeGroupData(12, gastos[12], isTouched: i == touchedIndex);

          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String mes;
              switch (group.x.toInt()) {
                case 0:
                  mes = 'janeiro';
                  break;
                case 1:
                  mes = 'fevereiro';
                  break;
                case 2:
                  mes = 'março';
                  break;
                case 3:
                  mes = 'abril';
                  break;
                case 4:
                  mes = 'maio';
                  break;
                case 5:
                  mes = 'junho';
                  break;
                case 6:
                  mes = 'julho';
                  break;
                case 7:
                  mes = 'Agosto';
                  break;
                case 8:
                  mes = 'Setembro';
                  break;
                case 9:
                  mes = 'Outubro';
                  break;
                case 10:
                  mes = 'Novembro';
                  break;
                case 11:
                  mes = 'Dezembro';
                  break;
              }
              return BarTooltipItem(
                  mes + '\n' + 'R\$ ' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.white, fontFamily: 'Poppins'));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Janeiro';
              case 1:
                return 'Fevereiro';
              case 2:
                return 'Março';
              case 3:
                return 'Abril';
              case 4:
                return 'Maio';
              case 5:
                return 'Junho';
              case 6:
                return 'Julho';
              case 7:
                return 'Agosto';
              case 8:
                return 'Setembro';
              case 9:
                return 'Outubro';
              case 10:
                return 'Novembro';
              case 11:
                return 'Dezembro';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}

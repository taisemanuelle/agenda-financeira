import 'package:agenda_app/modelo/despesa.dart';
import 'package:flutter/material.dart';
import 'package:agenda_app/widgets/itemDespesa.dart';

class ListaDespesa extends StatelessWidget {
  final List<Despesa> despesas;
  final Function excluiDespesa;

  ListaDespesa({this.despesas, this.excluiDespesa});

  @override
  Widget build(BuildContext context) {
    return despesas.isEmpty
        ? Column(
            children: [
              Text(
                'Nenhuma despesa adicionada!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/money.png',
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return ItemDespesa(
                  despesa: despesas[index], excluiDespesa: excluiDespesa);
            },
            itemCount: despesas.length,
          );
  }
}

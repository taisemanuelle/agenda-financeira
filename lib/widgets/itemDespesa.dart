import 'package:flutter/material.dart';
import 'package:agenda_app/modelo/despesa.dart';
import 'package:intl/intl.dart';

class ItemDespesa extends StatelessWidget {
  const ItemDespesa({
    Key key,
    @required this.despesa,
    @required this.excluiDespesa,
  }) : super(key: key);

  final Despesa despesa;
  final Function excluiDespesa;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(despesa.id),
      background: Container(
        color: Colors.red,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        excluiDespesa(despesa.id);
      },
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirmar"),
              content: Text("Tem certeza que quer excluir?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("EXCLUIR")),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("CANCELAR"),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'R\$ ${despesa.valor.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  despesa.titulo,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(despesa.data),
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

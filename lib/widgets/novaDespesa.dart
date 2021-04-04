import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NovaDespesa extends StatefulWidget {
  final Function addDespesa;

  NovaDespesa({this.addDespesa});
  @override
  NovaDespesaState createState() => NovaDespesaState();
}

class NovaDespesaState extends State<NovaDespesa> {
  final tituloController = TextEditingController();
  final valorController = TextEditingController();
  final dataController = TextEditingController();
  DateTime dataEscolhida;

  void onSubmit() {
    String titulo = tituloController.text;
    double valor = double.parse(valorController.text);

    if (titulo.isEmpty || valor <= 0 || dataEscolhida == null) {
      return;
    }

    widget.addDespesa(
      titulo: titulo,
      valor: valor,
      data: dataEscolhida,
    );
    Navigator.pop(context);
  }

  void inicioDataEscolhida() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.parse("2020-01-01 00:00:01Z"),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      dataEscolhida = value;
      dataController.text = DateFormat.yMMMd().format(dataEscolhida);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Titulo'),
                controller: tituloController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Valor',
                  prefixText: 'R\$s ',
                ),
                keyboardType: TextInputType.number,
                controller: valorController,
                onSubmitted: (_) => inicioDataEscolhida(),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 30,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: dataController,
                        decoration: InputDecoration(labelText: 'Data'),
                        enabled: false,
                      ),
                    ),
                    TextButton(
                      onPressed: inicioDataEscolhida,
                      child: Text(
                        'Escolha a data',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: onSubmit,
                child: Text(
                  'Adicionar despesa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

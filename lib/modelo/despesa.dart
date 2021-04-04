import 'package:flutter/cupertino.dart';

class Despesa {
  final String id;
  final String titulo;
  final double valor;
  final DateTime data;

  Despesa({
    @required this.id,
    @required this.titulo,
    @required this.valor,
    @required this.data,
  });
}

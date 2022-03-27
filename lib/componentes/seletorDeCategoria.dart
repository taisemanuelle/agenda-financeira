import 'package:agenda_app/controller/relatorioController.dart';
import 'package:flutter/material.dart';

class SeletorDeCategoria extends StatelessWidget {
  const SeletorDeCategoria({
    Key? key,
    required this.relatorioController,
    required this.text,
    required this.onPress,
    required this.textColor,
    required this.containerColor,
  }) : super(key: key);

  final RelatorioController relatorioController;
  final String text;
  final Function() onPress;
  final Color textColor;
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPress,
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

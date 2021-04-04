import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'modelo/despesa.dart';
import 'widgets/novaDespesa.dart';
import 'widgets/listaDespesa.dart';
import 'widgets/grafico.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Finaceira',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.white,
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Despesa> _userDespesas = [];

  void _addNovaDespesa({String titulo, double valor, DateTime data}) {
    final novaDespesa = Despesa(
      id: DateTime.now().toString(),
      titulo: titulo,
      valor: valor,
      data: data,
    );

    setState(() {
      _userDespesas.add(novaDespesa);
    });
  }

  void _inicioAddNovaDespesa(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => NovaDespesa(
        addDespesa: _addNovaDespesa,
      ),
      isScrollControlled: true,
    );
  }

  void _deletarDespesa(String id) {
    setState(() {
      _userDespesas.removeWhere((despesa) => despesa.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: Text('Agenda Financeira'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _inicioAddNovaDespesa(context),
        ),
      ],
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.5,
              child: GraficoDeBarras(
                despesas: _userDespesas,
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.5,
              child: ListaDespesa(
                despesas: _userDespesas.reversed.toList(),
                excluiDespesa: _deletarDespesa,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _inicioAddNovaDespesa(context),
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

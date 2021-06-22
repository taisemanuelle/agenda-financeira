import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String transferenciaTABLE = "transferenciaTABLE";
final String idColumn = "idColumn";
final String dataColumn = "dataColumn";
final String valorColumn = "valorColumn";
final String tipoColumn = "tipoColumn";
final String descricaoColumn = "descricaoColumn";

class TransferenciasHelper {
  static final TransferenciasHelper _instance = TransferenciasHelper.internal();

  factory TransferenciasHelper() => _instance;

  TransferenciasHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "transferencia.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE $transferenciaTABLE(" +
          "$idColumn INTEGER PRIMARY KEY," +
          "$valorColumn FLOAT," +
          "$dataColumn TEXT," +
          "$tipoColumn TEXT," +
          "$descricaoColumn TEXT)");
    });
  }

  Future<Transferencias> saveTransferencias(
      Transferencias transferencias) async {
    print("chamada save");
    Database dbTransferencias = await db;
    transferencias.id = await dbTransferencias.insert(
        transferenciaTABLE, transferencias.toMap());
    return transferencias;
  }

  Future<Transferencias> getMovimentacoes(int id) async {
    Database dbTransferencias = await db;
    List<Map> maps = await dbTransferencias.query(transferenciaTABLE,
        columns: [
          idColumn,
          valorColumn,
          dataColumn,
          tipoColumn,
          descricaoColumn
        ],
        where: "$idColumn =?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Transferencias.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteTransferencias(Transferencias transferencias) async {
    Database dbTransferencias = await db;
    return await dbTransferencias.delete(transferenciaTABLE,
        where: "$idColumn =?", whereArgs: [transferencias.id]);
  }

  Future<int> updateTransferencias(Transferencias transferencias) async {
    print("chamada update");
    print(transferencias.toString());
    Database dbMovimentacoes = await db;
    return await dbMovimentacoes.update(
        transferenciaTABLE, transferencias.toMap(),
        where: "$idColumn =?", whereArgs: [transferencias.id]);
  }

  Future<List> getAllTransferencias() async {
    Database dbTransferencias = await db;
    List listMap =
        await dbTransferencias.rawQuery("SELECT * FROM $transferenciaTABLE");
    List<Transferencias> listTransferencias = List();

    for (Map m in listMap) {
      listTransferencias.add(Transferencias.fromMap(m));
    }
    return listTransferencias;
  }

  Future<List> getAllTransferenciaPorMes(String data) async {
    Database dbTransferencias = await db;
    List listMap = await dbTransferencias.rawQuery(
        "SELECT * FROM $transferenciaTABLE WHERE $dataColumn LIKE '%$data%'");
    List<Transferencias> listTransferencias = List();

    for (Map m in listMap) {
      listTransferencias.add(Transferencias.fromMap(m));
    }
    return listTransferencias;
  }

  Future<List> getAllTransferenciaPorTipo(String tipo) async {
    Database dbTransferencias = await db;
    List listMap = await dbTransferencias.rawQuery(
        "SELECT * FROM $transferenciaTABLE WHERE $tipoColumn ='$tipo' ");
    List<Transferencias> listTransferencias = List();

    for (Map m in listMap) {
      listTransferencias.add(Transferencias.fromMap(m));
    }
    return listTransferencias;
  }

  Future<int> getNumber() async {
    Database dbTransferencias = await db;
    return Sqflite.firstIntValue(await dbTransferencias
        .rawQuery("SELECT COUNT(*) FROM $transferenciaTABLE"));
  }

  Future close() async {
    Database dbTransferencias = await db;
    dbTransferencias.close();
  }
}

class Transferencias {
  int id;
  String data;
  double valor;
  String tipo;
  String descricao;

  Transferencias();

  Transferencias.fromMap(Map map) {
    id = map[idColumn];
    valor = map[valorColumn];
    data = map[dataColumn];
    tipo = map[tipoColumn];
    descricao = map[descricaoColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      valorColumn: valor,
      dataColumn: data,
      tipoColumn: tipo,
      descricaoColumn: descricao,
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  String toString() {
    return "Tranferencias(id: $id, valor: $valor, data: $data, tipo: $tipo, desc: $descricao, )";
  }
}

class TransacaoModelo {
  TransacaoModelo({
    required this.id,
    required this.titulo,
    required this.anotacao,
    required this.valor,
    required this.ehReceita,
    required this.categoria,
    required this.dateTime,
  });

  final int? id;
  final String? titulo;
  final String? anotacao;
  final String? valor;
  final int? ehReceita;
  final String? categoria;
  final String? dateTime;

  factory TransacaoModelo.fromMap(Map<String, dynamic> json) =>
      TransacaoModelo(
        id: json["id"],
        titulo: json["titulo"],
        anotacao: json["anotacao"],
        valor: json["valor"],
        ehReceita: json["ehReceita"],
        categoria: json["categoria"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> transactionToMap() => {
        "id": id,
        "titulo": titulo,
        "anotacao": anotacao,
        "valor": valor,
        "ehReceita": ehReceita,
        "categoria": categoria,
        "dateTime": dateTime,
      };
}

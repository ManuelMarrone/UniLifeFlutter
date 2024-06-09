class Gruppo{
  List<String> partecipanti;
  List<String>  listaSpesa;
  Map<String,String> contatti;

  Gruppo({
    required this.partecipanti,
    required this.listaSpesa,
    required this.contatti,
  });

  Map<String, dynamic> toMap() {
    return {
      'partecipanti':partecipanti,
      'listaSpesa': listaSpesa,
      'contatti': contatti,
    };
  }

}

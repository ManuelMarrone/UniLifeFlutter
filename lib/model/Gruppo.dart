class Gruppo{
  List<String> partecipanti;
  List<String>  listaSpesa;
  Map<String,String> contatti;
  Map<String,String> documenti;

  Gruppo({
    required this.partecipanti,
    required this.listaSpesa,
    required this.contatti,
    required this.documenti
  });

  Map<String, dynamic> toMap() {
    return {
      'partecipanti':partecipanti,
      'listaSpesa': listaSpesa,
      'contatti': contatti,
      'documenti': documenti,
    };
  }

  static Gruppo fromMap(Map<String, dynamic> map) {
    return Gruppo(
      partecipanti: map['partecipanti'],
      listaSpesa: map['listaSpesa'],
      contatti: map['contatti'],
      documenti: map['documenti'],
    );
  }
}

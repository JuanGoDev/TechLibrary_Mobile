class ExemplaryUser {
  int id = 0;
  String idUsuario = '';
  int idEjemplar = 0;
  String fechaPrestamo = '';
  String fechaDevolucion = '';

  ExemplaryUser(
      {required this.id,
      required this.idUsuario,
      required this.idEjemplar,
      required this.fechaPrestamo,
      required this.fechaDevolucion});

  ExemplaryUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUsuario = json['idUsuario'];
    idEjemplar = json['idEjemplar'];
    fechaPrestamo = json['fechaPrestamo'];
    fechaDevolucion = json['fechaDevolucion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idUsuario'] = this.idUsuario;
    data['idEjemplar'] = this.idEjemplar;
    data['fechaPrestamo'] = this.fechaPrestamo;
    data['fechaDevolucion'] = this.fechaDevolucion;
    return data;
  }
}

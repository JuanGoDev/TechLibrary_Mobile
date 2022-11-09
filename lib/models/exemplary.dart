class Exemplary {
  int id = 0;
  int idLibro = 0;
  String localizacion = '';

  Exemplary(
      {required this.id, required this.idLibro, required this.localizacion});

  Exemplary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idLibro = json['idLibro'];
    localizacion = json['localizacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idLibro'] = this.idLibro;
    data['localizacion'] = this.localizacion;
    return data;
  }
}

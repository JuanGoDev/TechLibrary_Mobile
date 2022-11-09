// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class Author {
  int id = 0;
  int documento = 0;
  String nombre = '';
  String apellido = '';
  String sexo = '';
  String fechaNacimiento = '';
  String paisOrigen = '';
  String fotoAutor = '';

  Author(
      {required this.id,
      required this.documento,
      required this.nombre,
      required this.apellido,
      required this.sexo,
      required this.fechaNacimiento,
      required this.paisOrigen,
      required this.fotoAutor});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documento = json['documento'];
    nombre = json['nombre'];
    apellido = json['apellido'];
    sexo = json['sexo'];
    fechaNacimiento = json['fechaNacimiento'];
    paisOrigen = json['paisOrigen'];
    fotoAutor = json['fotoAutor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['documento'] = this.documento;
    data['nombre'] = this.nombre;
    data['apellido'] = this.apellido;
    data['sexo'] = this.sexo;
    data['fechaNacimiento'] = this.fechaNacimiento;
    data['paisOrigen'] = this.paisOrigen;
    data['fotoAutor'] = this.fotoAutor;
    return data;
  }
}

// ignore_for_file: file_names, unnecessary_new, prefer_collection_literals, unnecessary_this

class AuthorBook {
  int id = 0;
  int idLibro = 0;
  int idAutor = 0;
  String fechaPublicacion = '';

  AuthorBook(
      {required this.id,
      required this.idLibro,
      required this.idAutor,
      required this.fechaPublicacion});

  AuthorBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idLibro = json['idLibro'];
    idAutor = json['idAutor'];
    fechaPublicacion = json['fechaPublicacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idLibro'] = this.idLibro;
    data['idAutor'] = this.idAutor;
    data['fechaPublicacion'] = this.fechaPublicacion;
    return data;
  }
}

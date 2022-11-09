class Book {
  int id = 0;
  String titulo = '';
  int isbn = 0;
  String editorial = '';
  int paginas = 0;

  Book(
      {required this.id,
      required this.titulo,
      required this.isbn,
      required this.editorial,
      required this.paginas});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    isbn = json['isbn'];
    editorial = json['editorial'];
    paginas = json['paginas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['isbn'] = this.isbn;
    data['editorial'] = this.editorial;
    data['paginas'] = this.paginas;
    return data;
  }
}

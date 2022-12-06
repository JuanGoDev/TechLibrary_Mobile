// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_void_to_null, prefer_is_empty, unused_local_variable

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tech_library_mobile/components/loader_component.dart';
import 'package:tech_library_mobile/helpers/api_helper.dart';
import 'package:tech_library_mobile/models/book.dart';
import 'package:tech_library_mobile/models/response.dart';
import 'package:tech_library_mobile/models/token.dart';
import 'package:tech_library_mobile/screens/book_screen.dart';

class BooksScreen extends StatefulWidget {
  final Token token;

  BooksScreen({required this.token});

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<Book> _books = [];
  bool _showLoader = false;
  bool _isFiltered = false;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libros'),
        actions: <Widget>[
          _isFiltered
              ? IconButton(
                  onPressed: _removeFilter, icon: Icon(Icons.filter_none))
              : IconButton(onPressed: _showFilter, icon: Icon(Icons.filter_alt))
        ],
      ),
      body: Center(
        child: _showLoader
            ? LoaderComponent(text: 'Por favor espere...')
            : _getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _goAdd(),
      ),
    );
  }

  Future<Null> _getBooks() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estes conectado a internet.',
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    Response response = await ApiHelper.getBooks(widget.token);

    setState(() {
      _showLoader = false;
    });

    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    setState(() {
      _books = response.result;
    });
  }

  Widget _getContent() {
    return _books.length == 0 ? _noContent() : _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          _isFiltered
              ? 'No hay libros con ese criterio de búsqueda.'
              : 'No hay libros registrados.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getBooks,
      child: ListView(
        children: _books.map((e) {
          return Card(
            child: InkWell(
              onTap: () => _goEdit(e),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.titulo,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showFilter() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('Filtrar Libros'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Escriba las primeras letras del libro'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Criterio de búsqueda...',
                      labelText: 'Buscar',
                      suffixIcon: Icon(Icons.search)),
                  onChanged: (value) {
                    _search = value;
                  },
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')),
              TextButton(onPressed: () => _filter(), child: Text('Filtrar')),
            ],
          );
        });
  }

  void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getBooks();
  }

  void _filter() {
    if (_search.isEmpty) {
      return;
    }

    List<Book> filteredList = [];
    for (var book in _books) {
      if (book.titulo.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(book);
      }
    }

    setState(() {
      _books = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }

  void _goAdd() async {
    String? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookScreen(
                  token: widget.token,
                  book: Book(
                      id: 0, titulo: '', isbn: 0, editorial: '', paginas: 0),
                )));
    if (result == 'yes') {
      _getBooks();
    }
  }

  void _goEdit(Book book) async {
    String? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookScreen(
                  token: widget.token,
                  book: book,
                )));
    if (result == 'yes') {
      _getBooks();
    }
  }
}

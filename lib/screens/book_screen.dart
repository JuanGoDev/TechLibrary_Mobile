// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, unused_element, use_build_context_synchronously

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tech_library_mobile/components/loader_component.dart';
import 'package:tech_library_mobile/helpers/api_helper.dart';
import 'package:tech_library_mobile/models/book.dart';
import 'package:tech_library_mobile/models/response.dart';
import 'package:tech_library_mobile/models/token.dart';

class BookScreen extends StatefulWidget {
  final Token token;
  final Book book;

  BookScreen({required this.token, required this.book});

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  bool _showLoader = false;

  int _id = 0;
  String _titulo = '';
  int _isbn = 0;
  String _editorial = '';
  int _paginas = 0;

  String _idError = '';
  String _tituloError = '';
  String _isbnError = '';
  String _editorialError = '';
  String _paginasError = '';

  bool _idShowError = false;
  bool _tituloShowError = false;
  bool _isbnShowError = false;
  bool _editorialShowError = false;
  bool _paginasShowError = false;

  TextEditingController _idController = TextEditingController();
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _isbnController = TextEditingController();
  TextEditingController _editorialController = TextEditingController();
  TextEditingController _paginasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _id = widget.book.id;
    _titulo = widget.book.titulo;
    _isbn = widget.book.isbn;
    _editorial = widget.book.editorial;
    _paginas = widget.book.paginas;

    _idController.text = _id.toString();
    _tituloController.text = _titulo;
    _isbnController.text = _isbn.toString();
    _editorialController.text = _editorial;
    _paginasController.text = _paginas.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.id == 0 ? 'Nuevo libro' : widget.book.titulo),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _showId(),
              _showTitulo(),
              _showIsbn(),
              _showEditorial(),
              _showPaginas(),
              _showButtons()
            ],
          ),
          _showLoader
              ? LoaderComponent(
                  text: 'Por favor espere...',
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _showId() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _idController,
        decoration: InputDecoration(
          hintText: 'Ingresa un identificador...',
          labelText: 'Identificador',
          errorText: _idShowError ? _idError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _id = int.parse(value);
        },
      ),
    );
  }

  Widget _showTitulo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _tituloController,
        decoration: InputDecoration(
          hintText: 'Ingresa el título...',
          labelText: 'Título',
          errorText: _tituloShowError ? _tituloError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _titulo = value;
        },
      ),
    );
  }

  Widget _showIsbn() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _isbnController,
        decoration: InputDecoration(
          hintText: 'Ingresa el isbn...',
          labelText: 'Isbn',
          errorText: _isbnShowError ? _isbnError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _isbn = int.parse(value);
        },
      ),
    );
  }

  Widget _showEditorial() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _editorialController,
        decoration: InputDecoration(
          hintText: 'Ingresa la editorial...',
          labelText: 'Editorial',
          errorText: _editorialShowError ? _editorialError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _editorial = value;
        },
      ),
    );
  }

  Widget _showPaginas() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _paginasController,
        decoration: InputDecoration(
          hintText: 'Ingresa el número de páginas...',
          labelText: 'Páginas',
          errorText: _paginasShowError ? _paginasError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _paginas = int.parse(value);
        },
      ),
    );
  }

  Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: Text('Guardar'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Color(0xFF120E43);
                }),
              ),
              onPressed: () => _save(),
            ),
          ),
          widget.book.id == 0
              ? Container()
              : SizedBox(
                  width: 20,
                ),
          widget.book.id == 0
              ? Container()
              : Expanded(
                  child: ElevatedButton(
                    child: Text('Borrar'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color(0xFFB4161B);
                      }),
                    ),
                    onPressed: () => _confirmDelete(),
                  ),
                ),
        ],
      ),
    );
  }

  void _save() {
    if (!_validateFields()) {
      return;
    }

    widget.book.id == 0 ? _addRecord() : _saveRecord();
  }

  bool _validateFields() {
    bool isValid = true;

    if (_titulo.isEmpty) {
      isValid = false;
      _tituloShowError = true;
      _tituloError = 'Debes ingresar un título.';
    } else {
      _tituloShowError = false;
    }

    setState(() {});
    return isValid;
  }

  void _addRecord() async {
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

    Map<String, dynamic> request = {
      'titulo': _titulo,
      'isbn': _isbn,
      'editorial': _editorial,
      'paginas': _paginas
    };

    Response response =
        await ApiHelper.post('/api/libros/', request, widget.token);

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

    Navigator.pop(context, 'yes');
  }

  void _saveRecord() async {
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

    Map<String, dynamic> request = {
      'id': widget.book.id,
      'titulo': _titulo,
      'isbn': _isbn,
      'editorial': _editorial,
      'paginas': _paginas
    };

    Response response = await ApiHelper.put(
        '/api/libros/', widget.book.id.toString(), request, widget.token);

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

    Navigator.pop(context, 'yes');
  }

  void _confirmDelete() async {
    var response = await showAlertDialog(
        context: context,
        title: 'Confirmación',
        message: '¿Estas seguro de querer borrar el registro?',
        actions: <AlertDialogAction>[
          AlertDialogAction(key: 'no', label: 'No'),
          AlertDialogAction(key: 'yes', label: 'Sí'),
        ]);

    if (response == 'yes') {
      _deleteRecord();
    }
  }

  void _deleteRecord() async {
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

    Response response = await ApiHelper.delete(
        '/api/libros/', widget.book.id.toString(), widget.token);

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
  }
}

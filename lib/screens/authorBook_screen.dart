// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_element, use_build_context_synchronously

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tech_library_mobile/components/loader_component.dart';
import 'package:tech_library_mobile/helpers/api_helper.dart';
import 'package:tech_library_mobile/models/authorBook.dart';
import 'package:tech_library_mobile/models/response.dart';
import 'package:tech_library_mobile/models/token.dart';

class AuthorBookScreen extends StatefulWidget {
  final Token token;
  final AuthorBook authorBook;

  AuthorBookScreen({required this.token, required this.authorBook});

  @override
  _AuthorBookScreenState createState() => _AuthorBookScreenState();
}

class _AuthorBookScreenState extends State<AuthorBookScreen> {
  bool _showLoader = false;

  int _idAutorLibro = 0;
  int _idLibro = 0;
  int _idAutor = 0;
  String _fechaPublicacion = '';

  String _idAutorLibroError = '';
  String _idLibroError = '';
  String _idAutorError = '';
  String _fechaPublicacionError = '';

  bool _idAutorLibroShowError = false;
  bool _idLibroShowError = false;
  bool _idAutorShowError = false;
  bool _fechaPublicacionShowError = false;

  TextEditingController _idAutorLibroController = TextEditingController();
  TextEditingController _idLibroController = TextEditingController();
  TextEditingController _idAutorController = TextEditingController();
  TextEditingController _fechaPublicacionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _idAutorLibro = widget.authorBook.id;
    _idLibro = widget.authorBook.idLibro;
    _idAutor = widget.authorBook.idAutor;
    _fechaPublicacion = widget.authorBook.fechaPublicacion;

    _idAutorLibroController.text = _idAutorLibro.toString();
    _idLibroController.text = _idLibro.toString();
    _idAutorController.text = _idAutor.toString();
    _fechaPublicacionController.text = _fechaPublicacion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.authorBook.id == 0
            ? 'Nuevo autor-libro'
            : widget.authorBook.fechaPublicacion),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _showIdAutorlibro(),
              _showIdLibro(),
              _showIdAutor(),
              _showFechaPublicacion(),
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

  Widget _showIdAutorlibro() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _idAutorLibroController,
        decoration: InputDecoration(
          hintText: 'Ingresa un identificador...',
          labelText: 'Identificador autor-libro',
          errorText: _idAutorLibroShowError ? _idAutorLibroError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _idAutorLibro = int.parse(value);
        },
      ),
    );
  }

  Widget _showIdLibro() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _idLibroController,
        decoration: InputDecoration(
          hintText: 'Ingresa el identificador del libro...',
          labelText: 'Identificador Libro',
          errorText: _idLibroShowError ? _idLibroError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _idLibro = int.parse(value);
        },
      ),
    );
  }

  Widget _showIdAutor() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _idAutorController,
        decoration: InputDecoration(
          hintText: 'Ingresa el identificador del autor...',
          labelText: 'Identificador Autor',
          errorText: _idAutorShowError ? _idAutorError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _idAutor = int.parse(value);
        },
      ),
    );
  }

  Widget _showFechaPublicacion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _fechaPublicacionController,
        decoration: InputDecoration(
          hintText: 'Ingresa fecha de publicación...',
          labelText: 'Fecha publicación',
          errorText: _fechaPublicacionShowError ? _fechaPublicacionError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _fechaPublicacion = value;
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
          widget.authorBook.id == 0
              ? Container()
              : SizedBox(
                  width: 20,
                ),
          widget.authorBook.id == 0
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

    widget.authorBook.id == 0 ? _addRecord() : _saveRecord();
  }

  bool _validateFields() {
    bool isValid = true;

    if (_fechaPublicacion.isEmpty) {
      isValid = false;
      _fechaPublicacionShowError = true;
      _fechaPublicacionError = 'Debes ingresar una fecha de publicación.';
    } else {
      _fechaPublicacionShowError = false;
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
      'idLibro': _idLibro,
      'idAutor': _idAutor,
      'fechaPublicacion': _fechaPublicacion
    };

    Response response =
        await ApiHelper.post('/api/autoresLibros/', request, widget.token);

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
      'id': widget.authorBook.id,
      'idLibro': _idLibro,
      'idAutor': _idAutor,
      'fechaPublicacion': _fechaPublicacion,
    };

    Response response = await ApiHelper.put('/api/autoresLibros/',
        widget.authorBook.id.toString(), request, widget.token);

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
        '/api/autoresLibros/', widget.authorBook.id.toString(), widget.token);

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

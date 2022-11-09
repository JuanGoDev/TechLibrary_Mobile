// ignore_for_file: unused_field, prefer_final_fields

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tech_library_mobile/components/loader_component.dart';
import 'package:tech_library_mobile/helpers/api_helper.dart';
import 'package:tech_library_mobile/models/author.dart';
import 'package:tech_library_mobile/models/response.dart';
import 'package:tech_library_mobile/models/token.dart';

class AuthorScreen extends StatefulWidget {
  final Token token;
  final Author author;

  AuthorScreen({required this.token, required this.author});

  @override
  _AuthorScreenState createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  bool _showLoader = false;

  int _id = 0;
  int _documento = 0;
  String _nombre = '';
  String _apellido = '';
  String _sexo = '';
  String _fechaNacimiento = '';
  String _paisOrigen = '';
  String _fotoAutor = '';

  String _idError = '';
  String _documentoError = '';
  String _nombreError = '';
  String _apellidoError = '';
  String _sexoError = '';
  String _fechaNacimientoError = '';
  String _paisOrigenError = '';
  String _fotoAutorError = '';

  bool _nombreShowError = false;
  bool _idShowError = false;
  bool _documentoShowError = false;
  bool _apellidoShowError = false;
  bool _sexoShowError = false;
  bool _fechaNacimientoShowError = false;
  bool _paisOrigenShowError = false;
  bool _fotoAutorShowError = false;
  bool _nombreErrorShowError = false;

  TextEditingController _idController = TextEditingController();
  TextEditingController _documentoController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _sexoController = TextEditingController();
  TextEditingController _fechaNacimientoController = TextEditingController();
  TextEditingController _paisOrigenController = TextEditingController();
  TextEditingController _fotoAutorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _id = widget.author.id;
    _documento = widget.author.documento;
    _nombre = widget.author.nombre;

    _idController.text = _id.toString();
    _nombreController.text = _nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.author.id == 0 ? 'Nuevo autor' : widget.author.nombre),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _showId(),
              _showName(),
              _showButtons(),
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
          labelText: 'Identificador autor',
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

  Widget _showName() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _nombreController,
        decoration: InputDecoration(
          hintText: 'Ingresa un nombre...',
          labelText: 'Nombre',
          errorText: _nombreShowError ? _nombreError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _nombre = value;
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
          widget.author.id == 0
              ? Container()
              : SizedBox(
                  width: 20,
                ),
          widget.author.id == 0
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

    widget.author.id == 0 ? _addRecord() : _saveRecord();
  }

  bool _validateFields() {
    bool isValid = true;

    if (_nombre.isEmpty) {
      isValid = false;
      _nombreShowError = true;
      _nombreError = 'Debes ingresar un nombre.';
    } else {
      _nombreShowError = false;
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
      'description': _nombre,
    };

    Response response =
        await ApiHelper.post('/api/autores/', request, widget.token);

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
      'id': widget.author.id,
      'nombre': _nombre,
    };

    Response response = await ApiHelper.put(
        '/api/autores/', widget.author.id.toString(), request, widget.token);

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
        '/api/autores/', widget.author.id.toString(), widget.token);

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

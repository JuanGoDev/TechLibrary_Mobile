import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tech_library_mobile/components/loader_component.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tech_library_mobile/models/exemplary.dart';
import 'package:tech_library_mobile/models/token.dart';

import '../helpers/api_helper.dart';
import '../models/response.dart';

class ExemplaryScreen extends StatefulWidget {
  final Token token;
  final Exemplary exemplary;

  ExemplaryScreen({required this.token, required this.exemplary});

  @override
  State<ExemplaryScreen> createState() => _ExemplaryScreenState();
}

class _ExemplaryScreenState extends State<ExemplaryScreen> {
  bool _showLoader = false;

  int _id = 0;
  int _idLibro = 0;
  String _Localizacion = '';

  String _idError = '';
  String _idLibroError = '';
  String _localizacionError = '';

  bool _idShowError = false;
  bool _idLibroShowError = false;
  bool _localizacionShowError = false;

  TextEditingController _idController = TextEditingController();
  TextEditingController _idLibroController = TextEditingController();
  TextEditingController _localizacionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _id = widget.exemplary.id;
    _idController.text = _id.toString();

    _idLibro = widget.exemplary.idLibro;
    _idLibroController.text = _idLibro.toString();

    _Localizacion = widget.exemplary.localizacion;
    _localizacionController.text = _Localizacion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exemplary.id == 0
            ? 'Nuevo Ejemplar'
            : widget.exemplary.localizacion),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              _showId(),
              _showIdLibro(),
              _showLocalizacion(),
              _showButtons()
            ],
          ),
          _showLoader
              ? LoaderComponent(
                  text: 'Por favor espere.....',
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

  Widget _showIdLibro() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _idLibroController,
        decoration: InputDecoration(
          hintText: 'Ingresa un identificador del libro...',
          labelText: 'Identificador libro',
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

  Widget _showLocalizacion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _localizacionController,
        decoration: InputDecoration(
          hintText: 'Ingresa una localización...',
          labelText: 'Localización',
          errorText: _localizacionShowError ? _localizacionError : null,
          suffixIcon: Icon(Icons.location_on),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _Localizacion = value;
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
          widget.exemplary.id == 0
              ? Container()
              : SizedBox(
                  width: 20,
                ),
          widget.exemplary.id == 0
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

    widget.exemplary.id == 0 ? _addRecord() : _saveRecord();
  }

  bool _validateFields() {
    bool isValid = true;
    if (_Localizacion.isEmpty) {
      isValid = false;
      _localizacionShowError = true;
      _localizacionError = 'Debes ingresar una localización';
    } else {
      _localizacionShowError = false;
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
      'localizacion': _Localizacion,
    };

    Response response =
        await ApiHelper.post('/api/ejemplares/', request, widget.token);

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

  _saveRecord() async {
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
      'id': widget.exemplary.id,
      'idLibro': _idLibro,
      'localizacion': _Localizacion,
    };

    Response response = await ApiHelper.put('/api/ejemplares/',
        widget.exemplary.id.toString(), request, widget.token);

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
        '/api/ejemplares/', widget.exemplary.id.toString(), widget.token);

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

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tech_library_mobile/components/loader_component.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tech_library_mobile/models/exemplaryUser.dart';
import 'package:tech_library_mobile/models/token.dart';
import '../helpers/api_helper.dart';
import '../models/response.dart';

class ExemplaryUserScreen extends StatefulWidget {
  final Token token;
  final ExemplaryUser exemplaryUser;

  ExemplaryUserScreen({required this.token, required this.exemplaryUser});

  @override
  State<ExemplaryUserScreen> createState() => _ExemplaryUserScreen();
}

class _ExemplaryUserScreen extends State<ExemplaryUserScreen> {
  bool _showLoader = false;

  int _id = 0;
  String _idUsuario = '';
  int _idEjemplar = 0;
  String _fechaDevolucion = '';
  String _fechaPrestamo = '';

  String _idError = '';
  String _idUsuarioError = '';
  String _idEjemplarError = '';
  String _fechaDevolucionError = '';
  String _fechaPrestamoError = '';

  bool _idShowError = false;
  bool _idUsuarioShowError = false;
  bool _idEjemplarShowError = false;
  bool _fechaDevolucionShowError = false;
  bool _fechaPrestamoShowError = false;

  TextEditingController _idController = TextEditingController();
  TextEditingController _idLibroController = TextEditingController();
  TextEditingController _idUsuarioController = TextEditingController();
  TextEditingController _idEjemplarController = TextEditingController();
  TextEditingController _fechaDevolucionController = TextEditingController();
  TextEditingController _fechaPrestamoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _id = widget.exemplaryUser.id;
    _idController.text = _id.toString();

    _idUsuario = widget.exemplaryUser.idUsuario;
    _idLibroController.text = _idUsuario;

    _idEjemplar = widget.exemplaryUser.idEjemplar;
    _idEjemplarController.text = _idEjemplar.toString();

    _fechaDevolucion = widget.exemplaryUser.fechaDevolucion;
    _fechaDevolucionController.text = _fechaDevolucion;

    _fechaPrestamo = widget.exemplaryUser.fechaPrestamo;
    _fechaPrestamoController.text = _fechaPrestamo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exemplaryUser.id == 0
            ? 'Nuevo Usuario Ejemplar'
            : widget.exemplaryUser.fechaDevolucion),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              _showId(),
              _showIdUsuario(),
              _showIdEjemplar(),
              _showFechaDevolucion(),
              _showFechaPrestamo(),
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

  Widget _showIdUsuario() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _idUsuarioController,
        decoration: InputDecoration(
          hintText: 'Ingresa un identificador de Usuario...',
          labelText: 'Identificador Usuario',
          errorText: _idUsuarioShowError ? _idUsuarioError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _idUsuario = value;
        },
      ),
    );
  }

  Widget _showIdEjemplar() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _idEjemplarController,
        decoration: InputDecoration(
          hintText: 'Ingresa un identificador Ejemplar...',
          labelText: 'Identificador Ejemplar',
          errorText: _idEjemplarShowError ? _idEjemplarError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _idEjemplar = int.parse(value);
        },
      ),
    );
  }

  Widget _showFechaDevolucion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _fechaDevolucionController,
        decoration: InputDecoration(
          hintText: 'Ingresa una Fecha de Devolucion...',
          labelText: 'Fecha Devolucion',
          errorText: _fechaDevolucionShowError ? _fechaDevolucionError : null,
          suffixIcon: Icon(Icons.location_on),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _fechaDevolucion = value;
        },
      ),
    );
  }

  Widget _showFechaPrestamo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _fechaPrestamoController,
        decoration: InputDecoration(
          hintText: 'Ingresa una Fecha de Prestamo...',
          labelText: 'Fecha Prestamo',
          errorText: _fechaPrestamoShowError ? _fechaPrestamoError : null,
          suffixIcon: Icon(Icons.location_on),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _fechaPrestamo = value;
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
          widget.exemplaryUser.id == 0
              ? Container()
              : SizedBox(
                  width: 20,
                ),
          widget.exemplaryUser.id == 0
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

    widget.exemplaryUser.id == 0 ? _addRecord() : _saveRecord();
  }

  bool _validateFields() {
    bool isValid = true;
    if (_fechaDevolucion.isEmpty) {
      isValid = false;
      _fechaDevolucionShowError = true;
      _fechaDevolucionError = 'Debes ingresar una localización';
    } else {
      _fechaDevolucionShowError = false;
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
      'fechaPrestamo': _fechaPrestamo,
      'fechaDevolucion': _fechaDevolucion,
    };

    Response response =
        await ApiHelper.post('/api/usuariosEjemplares/', request, widget.token);

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
      'id': widget.exemplaryUser.id,
      'idUsuario': widget.exemplaryUser.idUsuario,
      'idEjemplar': widget.exemplaryUser.idEjemplar,
      'fechaPrestamo': widget.exemplaryUser.fechaPrestamo,
      'fechaDevolucion': widget.exemplaryUser.fechaDevolucion,
    };

    Response response = await ApiHelper.put('/api/usuariosEjemplares/',
        widget.exemplaryUser.id.toString(), request, widget.token);

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
    //Coemtario de prueba
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

    Response response = await ApiHelper.delete('/api/usuariosEjemplares/',
        widget.exemplaryUser.id.toString(), widget.token);

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

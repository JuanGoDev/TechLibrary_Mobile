import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tech_library_mobile/components/loader_component.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tech_library_mobile/helpers/api_helper.dart';
import 'package:tech_library_mobile/models/exemplary.dart';
import '../models/response.dart';
import '../models/token.dart';
import 'exemplary_screen.dart';

class ExemplarysScreen extends StatefulWidget {
  final Token token;

  ExemplarysScreen({required this.token});

  @override
  State<ExemplarysScreen> createState() => _ExemplarysScreenState();
}

class _ExemplarysScreenState extends State<ExemplarysScreen> {
  List<Exemplary> _exemplarys = [];
  bool _showLoader = false;
  bool _isFiltered = false;

  String _search = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getExemplary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ejemplares"),
        actions: <Widget>[
          _isFiltered
              ? IconButton(
                  onPressed: _removeFilter, icon: Icon(Icons.filter_none))
              : IconButton(onPressed: _showFilter, icon: Icon(Icons.filter_alt))
        ],
      ),
      body: Center(
        child: _showLoader
            ? LoaderComponent(
                text: 'Por favor espere....',
              )
            : _getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _goAdd(),
      ),
    );
  }

  Future<Null> _getExemplary() async {
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
    Response response = await ApiHelper.getExemplarys(widget.token);
    setState(() {
      _showLoader = false;
    });
    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(
              key: null,
              label: 'Aceptar',
            )
          ]);
      return;
    }
    setState(() {
      _exemplarys = response.result;
    });
  }

  Widget _getContent() {
    return _exemplarys.length == 0 ? _noContent() : _getListView();
  }

  _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          _isFiltered
              ? 'No hay Ejemplares registrados'
              : 'No hay ejemplares registrados',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getExemplary,
      child: ListView(
        children: _exemplarys.map((e) {
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
                          e.id.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          e.localizacion,
                          style: TextStyle(fontSize: 16),
                        ),
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

  void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getExemplary();
  }

  void _showFilter() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('Filtrar Ejemplares'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Escriba las primeras letras del ejemplar'),
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

  _filter() {
    if (_search.isEmpty) {
      return;
    }

    List<Exemplary> filteredList = [];
    for (var autor in _exemplarys) {
      if (autor.localizacion.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(autor);
      }
    }

    setState(() {
      _exemplarys = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }

  void _goAdd() async {
    String? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExemplaryScreen(
                  token: widget.token,
                  exemplary: Exemplary(
                    id: 0,
                    idLibro: 0,
                    localizacion: '',
                  ),
                )));
    if (result == 'yes') {
      _getExemplary();
    }
  }

  void _goEdit(Exemplary exemplary) async {
    String? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExemplaryScreen(
                  token: widget.token,
                  exemplary: exemplary,
                )));
    if (result == 'yes') {
      _getExemplary();
    }
  }
}

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_library_mobile/models/token.dart';
import 'package:tech_library_mobile/screens/authorBooks_screen.dart';
import 'package:tech_library_mobile/screens/authors_screen.dart';
import 'package:tech_library_mobile/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class HomeScreen extends StatefulWidget {
  final Token token;

  HomeScreen({required this.token});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 213, 214, 214),
        appBar: AppBar(
          title: Text('TechLibrary App'),
          backgroundColor: Color.fromARGB(255, 0, 139, 182),
        ),
        body: _getBody(),
        drawer: _getMenu());
  }

  Widget _getBody() {
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(150),
            // ignore: sort_child_properties_last
            child: Image(
              image: AssetImage('images/Library_home.png'),
              width: 300,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'Bienvenid@ a su gestor de biblioteca preferido.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Llamar a TechLibraryApp'),
              SizedBox(
                width: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.blue,
                  child: IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    onPressed: () => launch("tel://+573134684587"),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Enviar mensaje al soporte'),
              SizedBox(
                width: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.green,
                  child: IconButton(
                    icon: Icon(
                      Icons.insert_comment,
                      color: Colors.white,
                    ),
                    onPressed: () => _sendMessage(),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _getMenu() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Image(
            image: AssetImage('images/login_R.png'),
          )),
          ListTile(
            leading: Icon(Icons.color_lens_outlined),
            title: const Text('Autores'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthorsScreen(
                            token: widget.token,
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.precision_manufacturing),
            title: const Text('AutorLibro'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthorBooksScreen(
                            token: widget.token,
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.badge),
            title: const Text('Ejemplares'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.toys),
            title: const Text('Libros'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.toys),
            title: const Text('Usuarios Ejemplares'),
            onTap: () {},
          ),
          Divider(
            color: Colors.black,
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () => _logOut(),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+573134682688',
      text: 'Hola soy ${widget.token} cliente del taller',
    );
    await launch('$link');
  }

  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRemembered', false);
    await prefs.setString('userBody', '');

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

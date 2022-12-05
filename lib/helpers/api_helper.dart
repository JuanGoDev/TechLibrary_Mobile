import 'dart:convert';

import 'package:tech_library_mobile/helpers/constans.dart';
import 'package:tech_library_mobile/models/author.dart';
import 'package:tech_library_mobile/models/authorBook.dart';
import 'package:tech_library_mobile/models/exemplary.dart';
import 'package:tech_library_mobile/models/exemplaryUser.dart';
import 'package:tech_library_mobile/models/response.dart';
import 'package:tech_library_mobile/models/token.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static var list;

/*
  static Future<Response> getVehicle(Token token, String id) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}/api/Vehicles/$id');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    var decodedJson = jsonDecode(body);
    return Response(isSuccess: true, result: Vehicle.fromJson(decodedJson));
  }*/

  /*
  static Future<Response> getHistory(Token token, String id) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}/api/Histories/$id');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    var decodedJson = jsonDecode(body);
    return Response(isSuccess: true, result: History.fromJson(decodedJson));
  }*/

  static Future<Response> getProcedures(Token token) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}/api/Procedures');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    return Response(isSuccess: true, result: list);
  }

  static Future<Response> getAuthors(Token token) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}/api/autores');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    List<Author> list = [];
    var decodedJson = jsonDecode(body);
    if (decodedJson != null) {
      for (var item in decodedJson) {
        list.add(Author.fromJson(item));
      }
    }

    return Response(isSuccess: true, result: list);
  }

  static Future<Response> getAuthorBooks(Token token) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}/api/autoresLibros');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    List<AuthorBook> list = [];
    var decodedJson = jsonDecode(body);
    if (decodedJson != null) {
      for (var item in decodedJson) {
        list.add(AuthorBook.fromJson(item));
      }
    }

    return Response(isSuccess: true, result: list);
  }

  static Future<Response> getExemplarys(Token token) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}/api/ejemplares');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    List<Exemplary> list = [];
    var decodedJson = jsonDecode(body);
    if (decodedJson != null) {
      for (var item in decodedJson) {
        list.add(Exemplary.fromJson(item));
      }
    }

    return Response(isSuccess: true, result: list);
  }

  static Future<Response> getExemplaryUser(Token token) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}/api/usuariosEjemplares');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    List<ExemplaryUser> list = [];
    var decodedJson = jsonDecode(body);
    if (decodedJson != null) {
      for (var item in decodedJson) {
        list.add(ExemplaryUser.fromJson(item));
      }
    }

    return Response(isSuccess: true, result: list);
  }
/*
  static Future<Response> getDocumentTypes() async {
    var url = Uri.parse('${Constans.apiUrl}/api/DocumentTypes');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    List<DocumentType> list = [];
    var decodedJson = jsonDecode(body);
    if (decodedJson != null) {
      for (var item in decodedJson) {
        list.add(DocumentType.fromJson(item));
      }
    }

    return Response(isSuccess: true, result: list);
  }*/

  /*static Future<Response> getVehicleTypes(Token token) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}/api/VehicleTypes');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    List<VehicleType> list = [];
    var decodedJson = jsonDecode(body);
    if (decodedJson != null) {
      for (var item in decodedJson) {
        list.add(VehicleType.fromJson(item));
      }
    }

    return Response(isSuccess: true, result: list);
  }*/

/*
  static Future<Response> getUsers(Token token) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}/api/Users');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    List<User> list = [];
    var decodedJson = jsonDecode(body);
    if (decodedJson != null) {
      for (var item in decodedJson) {
        list.add(User.fromJson(item));
      }
    }

    return Response(isSuccess: true, result: list);
  }*/

/*
  static Future<Response> getUser(Token token, String id) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}/api/Users/$id');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    var decodedJson = jsonDecode(body);
    return Response(isSuccess: true, result: User.fromJson(decodedJson));
  }
  */

  static Future<Response> put(String controller, String id,
      Map<String, dynamic> request, Token token) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}$controller$id');
    var response = await http.put(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
      body: jsonEncode(request),
    );

    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: response.body);
    }

    return Response(isSuccess: true);
  }

  static Future<Response> post(
      String controller, Map<String, dynamic> request, Token token) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}$controller');
    var response = await http.post(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
      body: jsonEncode(request),
    );

    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: response.body);
    }

    return Response(isSuccess: true);
  }

  static Future<Response> postNoToken(
      String controller, Map<String, dynamic> request) async {
    var url = Uri.parse('${Constans.apiUrl}$controller');
    var response = await http.post(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode(request),
    );

    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: response.body);
    }

    return Response(isSuccess: true);
  }

  static Future<Response> delete(
      String controller, String id, Token token) async {
    if (!_validToken(token)) {
      return Response(
          isSuccess: false,
          message:
              'Sus credenciales se han vencido, por favor cierre sesión y vuelva a ingresar al sistema.');
    }

    var url = Uri.parse('${Constans.apiUrl}$controller$id');
    var response = await http.delete(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: response.body);
    }

    return Response(isSuccess: true);
  }

  static bool _validToken(Token token) {
    if (DateTime.parse(token.expiracion).isAfter(DateTime.now())) {
      return true;
    }

    return false;
  }
}

import 'dart:convert';

import 'package:sigma_test/model/sigmat.dart';
import 'package:http/http.dart' as http;

Future<List<SigmaModel>> SigmaApi() async {
  final response = await http.get('https://sigmatenant.com/mobile/tags');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = await json.decode(response.body)["tags"];
    return jsonResponse.map((e) => SigmaModel.fromJson(e)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

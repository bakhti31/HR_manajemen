// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

class Server {
  var ServerAddress = "192.168.1.1:3000";

  Future<void> POSTMethod(String where, JsonDecoder data) async {
    final response = await http.post(Uri.parse('$ServerAddress/$where'),
        headers: {'Content-Type': 'application/json'}, body: json.encode(data));
    if (response.statusCode != 200) {
      throw Exception('Failed to mark attendance');
    }
  }

  Future<List> GETMethod(String where, JsonDecoder data) async {
    final response = await http.get(
      Uri.parse('$ServerAddress/$where'),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Accept': '*/*'
      },
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.toList();
    } else {
      throw Exception('Failed to load performance data');
    }
  }
}

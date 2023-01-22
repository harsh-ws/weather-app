import 'dart:convert';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  var url;

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

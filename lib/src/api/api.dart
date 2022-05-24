import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String _baseUrl = "http://anainfo-node.herokuapp.com/users/";

  postLogin(data, apiUrl) async {
    var url = _baseUrl + apiUrl;
    var response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: _setHeaders());
    return json.decode(response.body);
  }
  postSignup(data, apiUrl) async {
    var url = _baseUrl + apiUrl;
    var response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: _setHeaders());
    return json.decode(response.body);
  }
  postLeave(data, apiUrl) async {
    var url = _baseUrl + apiUrl;
    var response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: _setHeaders());
    return json.decode(response.body);
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}

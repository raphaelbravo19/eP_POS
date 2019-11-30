import 'dart:convert';

import 'package:epaisa_pos/helpers/util/core.dart';
import 'package:http/http.dart' show Client, Response;

abstract class BaseNetwork {
  Client client = Client();

  Future<Response> post(String endpoint, String request) async {
    Future<Response> response;
    try {
      Map<String, dynamic> body = {
        'requestParams': request
            .replaceAll('+', '-')
            .replaceAll('=', ',')
            .replaceAll('/', '_'),
        'clientId': Core().clientId
      };
      return await client.post(Core().baseUrl + endpoint,
          body: body,
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          encoding: Encoding.getByName("utf-8"));
    } catch (e) {
      print("Login Exception: $e");

      if (e != null && e.message != null)
        response = getFailureResponse(e.message.toString());
      else
        response = getFailureResponse("Network Issue");
    }

    return response;
  }

  Future<Response> getFailureResponse(String error) async {
    Map<String, dynamic> res = Map();
    res['success'] = 0;
    res['message'] = error;

    return Response(json.encode(res), 200);
  }

  Future<Response> put(String endpoint, String request) async {
    var response;
    try {
      Map<String, dynamic> body = {
        'requestParams': request
            .replaceAll('+', '-')
            .replaceAll('=', ',')
            .replaceAll('/', '_'),
        'clientId': Core().clientId
      };
      return await client.put(Core().baseUrl + endpoint,
          body: body,
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          encoding: Encoding.getByName("utf-8"));
//    return response;
    } catch (e) {
      if (e != null && e.message != null)
        response = getFailureResponse(e.message.toString());
      else
        response = getFailureResponse("Network Issue");
    }
    return response;
  }

  Future<Response> get(String endpoint, String request) async {
    var response;
    try {
      return await client.get(Core().baseUrl +
          endpoint +
          '?requestParams=' +
          request
              .replaceAll('+', '-')
              .replaceAll('=', ',')
              .replaceAll('/', '_') +
          '&clientId=' +
          Core().clientId);
    } catch (e) {
      if (e != null && e.message != null)
        response = getFailureResponse(e.message.toString());
      else
        response = getFailureResponse("Network Issue");
    }
    return response;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../helpers/exceptions.dart';

enum HttpMethod { get, post, put, delete }

class ApiService {
  final client = http.Client();
  final baseUrl = 'https://swapi.dev/api';

  Future request({
    required String uri,
    HttpMethod httpMethod = .get,
    String? id,
    Map<String, dynamic>? data,
    Map<String, String>? queryParams,
    Function? parser,
  }) async {
    Uri url = Uri.parse('$baseUrl/$uri');

    if (queryParams != null) {
      url = url.replace(queryParameters: queryParams);
    }

    if (id != null) {
      url = url.replace(path: '$url/$id');
    }

    if (kDebugMode) {
      print('ApiService Request: ${httpMethod.toString().toUpperCase()} $url');
    }


    http.Response response;

    try {
      switch (httpMethod) {
        case HttpMethod.post:
          response = await client.post(url, body: jsonEncode(data));
        case HttpMethod.put:
          response = await client.put(url, body: jsonEncode(data));
        case HttpMethod.delete:
          response = await client.delete(url);
        default:
          response = await client.get(url);
      }

      if (kDebugMode) {
        //print(response.body);
      }

      switch (response.statusCode) {
        case HttpStatus.created:
        case HttpStatus.ok:
          if (response.body.isEmpty) {
            return null;
          }

          if (parser != null) {
            return parser(jsonDecode(response.body));
          }

          return jsonDecode(response.body);
        case HttpStatus.unprocessableEntity:
          return ApiFieldsException.fromJson(jsonDecode(response.body));
        default:
          throw ApiException(
            httpStatus: response.statusCode,
            message: response.body,
          );
      }
    } on http.ClientException catch (e) {
      print('HTTP Client Exception: $e');
      throw Exception('Failed to make API request: $e');
    } catch (e) {
      print('General Exception: $e');
      throw Exception('An error occurred: $e');
    }
  }
}

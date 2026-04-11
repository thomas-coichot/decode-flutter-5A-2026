import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../helpers/exceptions.dart';

enum HttpMethod { get, post, put, delete }

class ApiService {
  // Permet de créer un singleton
  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal();

  final client = http.Client();
  final baseUrl = 'https://swapi.dev/api';

  Future<T> request<T>({
    required String uri,
    HttpMethod httpMethod = .get,
    String? id,
    Map<String, dynamic>? data,
    Map<String, String>? queryParams,
    T Function(Map<String, dynamic>)? parser,
  }) async {
    Uri url = Uri.parse('$baseUrl/$uri');

    if (id != null) {
      url = Uri.parse('$baseUrl/$uri/$id');
    }

    if (queryParams != null) {
      url = url.replace(queryParameters: queryParams);
    }

    if (kDebugMode) {
      print('${httpMethod.name.toUpperCase()} : $url');
    }
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    http.Response response;

    try {
      switch (httpMethod) {
        case HttpMethod.post:
          response = await client.post(
            url,
            body: jsonEncode(data),
            headers: headers,
          );
        case HttpMethod.put:
          response = await client.put(
            url,
            body: jsonEncode(data),
            headers: headers,
          );
        case HttpMethod.delete:
          response = await client.delete(url, headers: headers);
        default:
          response = await client.get(url, headers: headers);
      }

      if (kDebugMode) {
        //print(response.body);
      }

      switch (response.statusCode) {
        case HttpStatus.created:
        case HttpStatus.ok:
          if (response.body.isEmpty) {
            return null as T;
          }

          if (parser != null) {
            return parser(jsonDecode(response.body));
          }

          return jsonDecode(response.body);
        case HttpStatus.unprocessableEntity:
          throw ApiFieldsException.fromJson(jsonDecode(response.body));
        case HttpStatus.noContent:
          return null as T;
        default:
          throw ApiException(
            httpStatus: response.statusCode,
            message: response.body,
          );
      }
    } on ApiException {
      rethrow;
    } on ApiFieldsException {
      rethrow;
    } on http.ClientException catch (e) {
      throw ApiException(httpStatus: 0, message: 'Erreur réseau: $e');
    } catch (e) {
      throw ApiException(httpStatus: 0, message: 'Erreur inattendue: $e');
    }
  }
}

import 'dart:io';

class ApiException implements Exception {
  final int httpStatus;
  final String message;

  const ApiException({required this.httpStatus, required this.message});

  @override
  String toString() => 'ApiException: $httpStatus - $message';
}

class ApiField {
  final String name;
  final String message;

  const ApiField({required this.name, required this.message});

  @override
  String toString() => 'ApiField: $name - $message';
}

class ApiFieldsException implements Exception {
  final int httpStatus;
  final String message;
  final List<ApiField> fields;

  const ApiFieldsException({
    required this.httpStatus,
    required this.message,
    required this.fields,
  });

  factory ApiFieldsException.fromJson(Map<String, dynamic> json) {
    return ApiFieldsException(
      httpStatus: 422,
      message: json['message'],
      fields: json['fields'],
    );
  }

  @override
  String toString() =>
      'ApiFieldsException: $httpStatus - $message : ${fields.map((e) => e.toString()).join(',')}';
}

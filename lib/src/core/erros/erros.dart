import 'package:flutter/material.dart' show BuildContext;

/// The [ErrorEntity] class represents a generic error entity with a code and a message.
class ErrorEntity {
  /// The error code.
  final String code;

  /// The error message (default value: 'Ha ocurrido un error inesperado').
  final String message;

  /// Constructs an [ErrorEntity] instance with the specified parameters.
  ErrorEntity({
    required this.code,
    this.message = 'Ha ocurrido un error inesperado',
  });
}

/// The [ErrorModel] class extends [ErrorEntity] and represents a specific error model.
class ErrorModel extends ErrorEntity {
  /// Constructs an [ErrorModel] instance with the specified parameters.
  ErrorModel({
    required super.code,
    super.message,
  });

  /// Factory method to create an [ErrorModel] instance from a JSON map.
  ///
  /// Takes a [BuildContext] as a parameter, which is not used in this implementation.
  factory ErrorModel.fromJson(
    BuildContext context,
    Map<String, dynamic> json,
  ) {
    return ErrorModel(
      code: json['code'],
      message: json['message'],
    );
  }
}

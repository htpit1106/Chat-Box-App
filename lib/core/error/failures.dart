import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
  @override
  String toString() => message;
}

// Specific Failure types (examples)
class ServerFailure extends Failure {
  const ServerFailure({String message = 'An API error occurred'})
    : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Could not connect to the network'})
    : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Could not access local cache'})
    : super(message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = 'The requested item was not found'})
    : super(message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({String message = 'An unexpected error occurred'})
    : super(message);
}

class ApiFailure extends Failure {
  const ApiFailure({String message = 'An unexpected error occurred'})
    : super(message);
}

Failure mapExceptionToFailure(dynamic e) {
  // Add more specific exception handling (e.g., for DioError, SocketException)
  if (e is FormatException) {
    return ServerFailure(
      message: "common_message_bad_response_format_from_server",
    );
  }

  if (e is SocketException) {
    return ServerFailure(message: "common_message_connection_timed_out");
  }

  ;
  return UnexpectedFailure(message: "common_message_uncatch_error");
}

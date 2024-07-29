import 'package:autotureid/core/constants.dart';

abstract class Failure {
  final String message;
  Failure({
    required this.message,
  });
}

class ConnectionFailure extends Failure {
  ConnectionFailure({
    super.message = kConnectionFailMessage,
  });
}

class BadRequestFailure extends Failure {
  BadRequestFailure({required super.message});
}

// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String NETWORK_FAILURE_MESSAGE = 'network Connection Failure';
const String INPUT_FAILURE_MESSAGE = 'Input Failure';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

//General Faliures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class InvalidInputFailure extends Failure {}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    case NetworkFailure:
      return NETWORK_FAILURE_MESSAGE;
    case InvalidInputFailure:
      return INPUT_FAILURE_MESSAGE;
    default:
      return "Unexpected error";
  }
}

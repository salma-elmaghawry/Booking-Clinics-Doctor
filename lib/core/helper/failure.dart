import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class Failure {
  final String ex;
  const Failure(this.ex);
}

final class DioFailure extends Failure {
  const DioFailure._(super.ex);

  factory DioFailure(serviceError) {
    switch (serviceError.error) {
      case DioExceptionType.connectionTimeout:
        return const DioFailure._('Connect timeout.');
      case DioExceptionType.sendTimeout:
        return const DioFailure._('Send timeout.');
      case DioExceptionType.receiveTimeout:
        return const DioFailure._('Receive timeout.');
      case DioExceptionType.badResponse:
        debugPrint('helloooooooo');
        return DioFailure._fromResponse(
          serviceError.response?.statusCode,
          serviceError.response?.statusMessage,
        );
      case DioExceptionType.cancel:
        return const DioFailure._('Request was canceled.');
      case DioExceptionType.unknown:
        if (serviceError.message == 'SocketException') {
          return const DioFailure._('Check Internet.');
        } else {
          return const DioFailure._('Unknown error, Please try later!');
        }
      default:
        return const DioFailure._('Oops... Please try later!');
    }
  }

  factory DioFailure._fromResponse(int? code, data) {
    if (code == 400 || code == 401 || code == 403) {
      return DioFailure._(data['error']['message']);
    } else if (code == 404) {
      return const DioFailure._('Request Not Found.');
    } else if (code == 500) {
      return const DioFailure._('Internal Server Failure.');
    }
    return const DioFailure._('Oops... Response failure!');
  }
}

final class UnknownFailure extends Failure {
  const UnknownFailure(super.ex);
}

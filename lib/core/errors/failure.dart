import 'package:dio/dio.dart';

/// ========================================================
/// Abstract Base Failure
/// ========================================================
abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

/// ========================================================
/// Server / API Failures
/// Handles errors from Dio / API responses
/// ========================================================
class ServerFailure extends Failure {
  const ServerFailure(super.errMessage);

  /// Convert DioException into ServerFailure
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout with API server');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout from API server');
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final data = dioError.response?.data;
        return ServerFailure.fromResponse(statusCode, data);
      case DioExceptionType.cancel:
        return const ServerFailure('Request to API server was canceled');
      case DioExceptionType.unknown:
        final errorMessage = dioError.error?.toString() ?? '';
        if (errorMessage.contains('SocketException')) {
          return const ServerFailure('No Internet connection');
        }
        return const ServerFailure('Unexpected error, please try again!');
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.connectionError:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  /// Convert API Response into ServerFailure
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (response is Map<String, dynamic> && response['error'] != null) {
      final errorMessage = response['error']['message']?.toString();
      if (errorMessage != null && errorMessage.isNotEmpty) {
        return ServerFailure(errorMessage);
      }
    }

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return const ServerFailure('Unauthorized or bad request');
      case 404:
        return const ServerFailure('Resource not found, please try later');
      case 500:
        return const ServerFailure('Internal server error, please try later');
      default:
        return const ServerFailure('Oops! Something went wrong, please try again');
    }
  }
}

/// ========================================================
/// Cache / Local Storage Failures
/// Handles errors from Hive, SharedPreferences, or other local storage
/// ========================================================
class CacheFailure extends Failure {
  const CacheFailure(super.errMessage);

  factory CacheFailure.emptyCache() => const CacheFailure('No data found in cache');

  factory CacheFailure.writeError() => const CacheFailure('Failed to write to cache');

  factory CacheFailure.readError() => const CacheFailure('Failed to read from cache');
}

/// ========================================================
/// Network / Connection Failures
/// Handles errors related to Internet connectivity
/// ========================================================
class NetworkFailure extends Failure {
  const NetworkFailure(super.errMessage);

  factory NetworkFailure.noConnection() => const NetworkFailure('No Internet connection');

  factory NetworkFailure.timeout() => const NetworkFailure('Connection timed out');
}

/// ========================================================
/// Generic / Unknown Failures
/// Handles any other Exception not covered by the above
/// ========================================================
class GenericFailure extends Failure {
  const GenericFailure(super.errMessage);

  factory GenericFailure.fromException(Exception e) =>
      GenericFailure(e.toString());
}

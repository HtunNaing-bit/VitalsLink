/// Base Exception class
class AppException implements Exception {
  final String message;
  final dynamic originalError;

  const AppException(this.message, [this.originalError]);

  @override
  String toString() => message;
}

/// Server Exception
class ServerException extends AppException {
  const ServerException(super.message, [super.originalError]);
}

/// Network Exception
class NetworkException extends AppException {
  const NetworkException(super.message, [super.originalError]);
}

/// Cache Exception
class CacheException extends AppException {
  const CacheException(super.message, [super.originalError]);
}

/// Permission Exception
class PermissionException extends AppException {
  const PermissionException(super.message, [super.originalError]);
}

/// Platform Exception (HealthKit/Google Fit)
class PlatformException extends AppException {
  const PlatformException(super.message, [super.originalError]);
}

/// Validation Exception
class ValidationException extends AppException {
  const ValidationException(super.message, [super.originalError]);
}


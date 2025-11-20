import 'package:equatable/equatable.dart';

/// Base Failure class
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Server Failure
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Network Failure
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Cache Failure
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Permission Failure
class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

/// Platform Failure (HealthKit/Google Fit errors)
class PlatformFailure extends Failure {
  const PlatformFailure(super.message);
}

/// Validation Failure
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Unknown Failure
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}


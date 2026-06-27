import '../models/app_error_code.dart';

class WebDavOperationResult {
  const WebDavOperationResult._({
    required this.success,
    required this.statusCode,
    this.errorCode,
  });

  factory WebDavOperationResult.ok({required int statusCode}) => WebDavOperationResult._(
        success: true,
        statusCode: statusCode,
      );

  factory WebDavOperationResult.failed({
    required int statusCode,
    required AppErrorCode errorCode,
  }) => WebDavOperationResult._(
        success: false,
        statusCode: statusCode,
        errorCode: errorCode,
      );

  final bool success;
  final int statusCode;
  final AppErrorCode? errorCode;
}

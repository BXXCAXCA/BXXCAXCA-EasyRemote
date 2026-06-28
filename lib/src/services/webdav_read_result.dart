import '../models/app_error_code.dart';

class WebDavReadResult {
  const WebDavReadResult._({
    required this.success,
    required this.statusCode,
    this.content,
    this.errorCode,
  });

  factory WebDavReadResult.ok({
    required int statusCode,
    required String content,
  }) =>
      WebDavReadResult._(
        success: true,
        statusCode: statusCode,
        content: content,
      );

  factory WebDavReadResult.failed({
    required int statusCode,
    required AppErrorCode errorCode,
  }) =>
      WebDavReadResult._(
        success: false,
        statusCode: statusCode,
        errorCode: errorCode,
      );

  final bool success;
  final int statusCode;
  final String? content;
  final AppErrorCode? errorCode;
}

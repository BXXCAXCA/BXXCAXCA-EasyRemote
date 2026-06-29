import '../models/app_error_code.dart';
import 'webdav_client.dart';

class WebDavListResult {
  const WebDavListResult._({
    required this.success,
    required this.statusCode,
    this.resources = const [],
    this.errorCode,
  });

  factory WebDavListResult.ok({
    required int statusCode,
    required List<WebDavResource> resources,
  }) =>
      WebDavListResult._(
        success: true,
        statusCode: statusCode,
        resources: resources,
      );

  factory WebDavListResult.failed({
    required int statusCode,
    required AppErrorCode errorCode,
  }) =>
      WebDavListResult._(
        success: false,
        statusCode: statusCode,
        errorCode: errorCode,
      );

  final bool success;
  final int statusCode;
  final List<WebDavResource> resources;
  final AppErrorCode? errorCode;
}

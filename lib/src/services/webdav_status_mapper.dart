import '../models/app_error_code.dart';

class WebDavStatusMapper {
  const WebDavStatusMapper();

  AppErrorCode mapStatus(int statusCode) {
    if (statusCode == 401 || statusCode == 403) {
      return AppErrorCode.authRequired;
    }
    if (statusCode == 404) {
      return AppErrorCode.remoteNotFound;
    }
    if (statusCode == 409 || statusCode == 412 || statusCode == 423) {
      return AppErrorCode.conflictDetected;
    }
    if (statusCode == 400 || statusCode == 422) {
      return AppErrorCode.validationFailed;
    }
    if (statusCode >= 500 && statusCode < 600) {
      return AppErrorCode.networkUnavailable;
    }
    return AppErrorCode.unknown;
  }
}

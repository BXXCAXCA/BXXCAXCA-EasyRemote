import '../models/app_error_code.dart';
import '../models/http_request_descriptor.dart';

class HttpErrorMapper {
  AppErrorCode map(HttpResponseDescriptor response) {
    if (response.statusCode == 401 || response.statusCode == 403) {
      return AppErrorCode.authRequired;
    }
    if (response.statusCode == 404) {
      return AppErrorCode.remoteNotFound;
    }
    if (response.statusCode == 409) {
      return AppErrorCode.conflictDetected;
    }
    if (response.statusCode >= 500) {
      return AppErrorCode.networkUnavailable;
    }
    if (!response.isSuccess) {
      return AppErrorCode.unknown;
    }
    return AppErrorCode.unknown;
  }
}

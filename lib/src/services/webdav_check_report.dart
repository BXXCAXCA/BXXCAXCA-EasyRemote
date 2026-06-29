import '../models/app_error_code.dart';

class WebDavCheckItem {
  const WebDavCheckItem({
    required this.id,
    required this.ok,
    required this.title,
    required this.detail,
    this.statusCode,
    this.errorCode,
  });

  final String id;
  final bool ok;
  final String title;
  final String detail;
  final int? statusCode;
  final AppErrorCode? errorCode;
}

class WebDavCheckReport {
  const WebDavCheckReport({
    required this.items,
  });

  final List<WebDavCheckItem> items;

  bool get ok => items.every((item) => item.ok);
}

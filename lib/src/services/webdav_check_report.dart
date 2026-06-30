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

  String get statusLabel => ok ? 'OK' : 'Needs attention';
}

class WebDavCheckReport {
  const WebDavCheckReport({
    required this.items,
    this.checkedAtIso = '',
  });

  final List<WebDavCheckItem> items;
  final String checkedAtIso;

  int get totalCount => items.length;
  int get passedCount => items.where((item) => item.ok).length;
  int get failedCount => totalCount - passedCount;
  bool get ok => failedCount == 0;

  String get summaryText => '$passedCount/$totalCount checks passed';
}

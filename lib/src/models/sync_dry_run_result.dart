class SyncDryRunResult {
  const SyncDryRunResult({
    required this.ok,
    required this.title,
    required this.details,
    required this.checkedAtIso,
  });
  final bool ok;
  final String title;
  final List<String> details;
  final String checkedAtIso;
}

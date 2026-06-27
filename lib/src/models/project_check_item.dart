class ProjectCheckItem {
  const ProjectCheckItem({
    required this.id,
    required this.ok,
    required this.title,
    required this.detail,
  });

  final String id;
  final bool ok;
  final String title;
  final String detail;
}

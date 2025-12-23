class PermissionRationale {
  final String title;
  final String message;
  final String? confirmText;
  final String? cancelText;

  const PermissionRationale({
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
  });
}

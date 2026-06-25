import 'package:flutter/material.dart';

class ConfirmationRequest {
  const ConfirmationRequest({
    required this.title,
    required this.message,
    this.confirmLabel = 'Continue',
    this.cancelLabel = 'Cancel',
    this.destructive = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool destructive;
}

abstract class ConfirmationService {
  Future<bool> confirm(BuildContext context, ConfirmationRequest request);
}

class MaterialConfirmationService implements ConfirmationService {
  const MaterialConfirmationService();

  @override
  Future<bool> confirm(BuildContext context, ConfirmationRequest request) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(request.title),
        content: Text(request.message),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(request.cancelLabel)),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: Text(request.confirmLabel)),
        ],
      ),
    );
    return result ?? false;
  }
}

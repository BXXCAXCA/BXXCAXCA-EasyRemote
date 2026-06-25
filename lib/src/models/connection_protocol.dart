import 'package:flutter/material.dart';

enum ConnectionProtocol {
  desktop,
  screen,
  shell,
  files,
  nativeSession;

  String get label {
    switch (this) {
      case ConnectionProtocol.desktop:
        return 'Desktop';
      case ConnectionProtocol.screen:
        return 'Screen';
      case ConnectionProtocol.shell:
        return 'Shell';
      case ConnectionProtocol.files:
        return 'Files';
      case ConnectionProtocol.nativeSession:
        return 'Native';
    }
  }

  IconData get icon {
    switch (this) {
      case ConnectionProtocol.desktop:
        return Icons.desktop_windows_outlined;
      case ConnectionProtocol.screen:
        return Icons.fit_screen_outlined;
      case ConnectionProtocol.shell:
        return Icons.terminal_outlined;
      case ConnectionProtocol.files:
        return Icons.folder_outlined;
      case ConnectionProtocol.nativeSession:
        return Icons.touch_app_outlined;
    }
  }
}

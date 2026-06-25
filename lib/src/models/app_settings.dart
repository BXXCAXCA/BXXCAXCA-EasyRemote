class AppSettings {
  const AppSettings({
    required this.webDavEnabled,
    required this.webDavUrl,
    required this.webDavUsername,
    required this.encryptionMode,
    required this.requireEntryConfirmation,
    required this.keepLocalHistory,
    required this.routeAutoSelectEnabled,
    required this.adapterSafetyReviewRequired,
  });

  factory AppSettings.defaults() => const AppSettings(
    webDavEnabled: false,
    webDavUrl: '',
    webDavUsername: '',
    encryptionMode: 'tiered',
    requireEntryConfirmation: true,
    keepLocalHistory: true,
    routeAutoSelectEnabled: true,
    adapterSafetyReviewRequired: true,
  );

  final bool webDavEnabled;
  final String webDavUrl;
  final String webDavUsername;
  final String encryptionMode;
  final bool requireEntryConfirmation;
  final bool keepLocalHistory;
  final bool routeAutoSelectEnabled;
  final bool adapterSafetyReviewRequired;

  AppSettings copyWith({
    bool? webDavEnabled,
    String? webDavUrl,
    String? webDavUsername,
    String? encryptionMode,
    bool? requireEntryConfirmation,
    bool? keepLocalHistory,
    bool? routeAutoSelectEnabled,
    bool? adapterSafetyReviewRequired,
  }) => AppSettings(
    webDavEnabled: webDavEnabled ?? this.webDavEnabled,
    webDavUrl: webDavUrl ?? this.webDavUrl,
    webDavUsername: webDavUsername ?? this.webDavUsername,
    encryptionMode: encryptionMode ?? this.encryptionMode,
    requireEntryConfirmation: requireEntryConfirmation ?? this.requireEntryConfirmation,
    keepLocalHistory: keepLocalHistory ?? this.keepLocalHistory,
    routeAutoSelectEnabled: routeAutoSelectEnabled ?? this.routeAutoSelectEnabled,
    adapterSafetyReviewRequired: adapterSafetyReviewRequired ?? this.adapterSafetyReviewRequired,
  );

  Map<String, Object?> toJson() => {
    'webDavEnabled': webDavEnabled,
    'webDavUrl': webDavUrl,
    'webDavUsername': webDavUsername,
    'encryptionMode': encryptionMode,
    'requireEntryConfirmation': requireEntryConfirmation,
    'keepLocalHistory': keepLocalHistory,
    'routeAutoSelectEnabled': routeAutoSelectEnabled,
    'adapterSafetyReviewRequired': adapterSafetyReviewRequired,
  };

  factory AppSettings.fromJson(Map<String, Object?> json) => AppSettings(
    webDavEnabled: json['webDavEnabled'] as bool? ?? false,
    webDavUrl: json['webDavUrl'] as String? ?? '',
    webDavUsername: json['webDavUsername'] as String? ?? '',
    encryptionMode: json['encryptionMode'] as String? ?? 'tiered',
    requireEntryConfirmation: json['requireEntryConfirmation'] as bool? ?? true,
    keepLocalHistory: json['keepLocalHistory'] as bool? ?? true,
    routeAutoSelectEnabled: json['routeAutoSelectEnabled'] as bool? ?? true,
    adapterSafetyReviewRequired: json['adapterSafetyReviewRequired'] as bool? ?? true,
  );
}

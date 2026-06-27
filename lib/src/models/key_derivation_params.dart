class KeyDerivationParams {
  const KeyDerivationParams({
    required this.algorithm,
    required this.iterations,
    required this.salt,
  });

  final String algorithm;
  final int iterations;
  final String salt;

  factory KeyDerivationParams.recommendedPlaceholder() => const KeyDerivationParams(
        algorithm: 'pbkdf2-placeholder',
        iterations: 100000,
        salt: 'demo-salt',
      );

  Map<String, Object?> toJson() => {
        'algorithm': algorithm,
        'iterations': iterations,
        'salt': salt,
      };
}

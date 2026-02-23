enum Environment {
  dev,
  stg,
  prod;

  bool get isProd => this == Environment.prod;
}

extension EnvironmentExt on Environment {
  String get envName {
    switch (this) {
      case Environment.dev:
        return 'DEV';
      case Environment.stg:
        return 'STAGING';
      case Environment.prod:
        return 'PROD';
    }
  }
}

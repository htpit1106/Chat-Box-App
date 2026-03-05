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

  String get baseUrl => "https://ovzntlyvpvhqqgmtzlyr.supabase.co";
  String get anonKey =>
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im92em50bHl2cHZocXFnbXR6bHlyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI1MTk2OTMsImV4cCI6MjA4ODA5NTY5M30.YRjd9_e3c0-782h38Mt4kn6kSr95p6csZCw16ncB1Rw";
}

abstract class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  static const String annonKey = String.fromEnvironment(
    'SUPABASE_ANNON_KEY',
    defaultValue: '',
  );
}

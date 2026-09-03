class ApiEndpoints {
  static const String _port = "8000";

  // ADB reverse ke zariye mobile localhost ko PC localhost samjhega
  static String get baseUrl => "http://127.0.0.1:$_port";

  static String get askTutor => "$baseUrl/api/v1/tutor/ask";
}

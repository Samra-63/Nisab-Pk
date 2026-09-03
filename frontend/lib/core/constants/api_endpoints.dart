class ApiEndpoints {
  // Laptop Mobile Hotspot IP
  static const String _hostIp = "192.168.137.1";
  static const String _port = "8000";

  static String get baseUrl => "http://$_hostIp:$_port";
  static String get askTutor => "$baseUrl/api/v1/tutor/ask";
}

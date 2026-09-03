import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_endpoints.dart';

class TutorApiService {
  static Future<Map<String, dynamic>> askTutor({
    required String query,
    required String board,
    required int grade,
    required String subject,
  }) async {
    final url = Uri.parse(ApiEndpoints.askTutor);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "query": query,
          "board": board.toLowerCase(),
          "grade": grade,
          "subject": subject.toLowerCase(),
        }),
      );

      final Map<String, dynamic> data = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (response.statusCode == 200) {
        return {
          "success": true,
          "answer": data["answer"] ?? "",
          "citations": List<int>.from(data["citations"] ?? []),
          "subject": data["subject"] ?? subject,
        };
      } else {
        return {
          "success": false,
          "error": data["detail"] ?? "Server error: ${response.statusCode}",
        };
      }
    } catch (e) {
      return {
        "success": false,
        "error":
            "Backend se rabta nahi ho saka. Make sure uvicorn is running.\nDetails: $e",
      };
    }
  }
}

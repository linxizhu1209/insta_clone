import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<String>> fetchServerData() async {
    try {
      final url = Uri.parse('http://10.0.2.2:8080/insta');
      final response = await http.get(url);

      if(response.statusCode == 200){
        //Json배열을 List<String>으로 변환
        List<dynamic> data = jsonDecode(response.body);
        return data.map((url) => fixUrl(url)).toList().cast<String>();
      } else {
        throw Exception("Error! ${response.statusCode}, body: ${response.body}");
      }

    } catch(e){
      throw Exception('Error 발생! $e');
    }
  }
}

// fixUrl 함수 정의
String fixUrl(String url) {
  return url.replaceAll("http://localhost", "http://10.0.2.2");
}

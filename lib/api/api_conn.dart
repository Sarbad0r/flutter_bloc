class ApiConnections {
  // static const String URL = 'http://192.168.0.106:8000/api';

  static Future<Map<String, String>> headers() async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
  }
}

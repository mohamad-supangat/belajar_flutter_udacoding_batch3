Map<String, String> config() {
  // String baseUrl = 'https://10.0.3.2:8000/';
  // String baseUrl = 'http://192.168.10.5:8000/';
  // String baseUrl = 'http://127.0.0.1:8000/';
  // String baseUrl = 'http://192.168.43.82:8000/';
  String baseUrl = 'http://192.168.57.1:8000/';

  return {
    'baseUrl': baseUrl,
    'apiUrl': '${baseUrl}api',
  };
}

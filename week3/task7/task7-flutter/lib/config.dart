Map<String, String> config() {
  // String baseUrl = 'http://10.0.2.2:8000/';
  // String baseUrl = 'http://192.168.57.1:8000/';
  String baseUrl = 'http://192.168.10.121:8000/';

  return {
    'baseUrl': baseUrl,
    'apiUrl': '${baseUrl}api',
  };
}

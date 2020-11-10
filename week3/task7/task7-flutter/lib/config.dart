Map<String, String> config() {
  // String baseUrl = 'http://192.168.10.108:8000/';
  String baseUrl = 'http://192.168.57.1:8000/';

  return {
    'baseUrl': baseUrl,
    'apiUrl': '${baseUrl}api',
  };
}

Map<String, String> config() {
  String baseUrl = 'http://10.0.2.2:8000/';
  return {
    'baseUrl': baseUrl,
    'apiUrl': '${baseUrl}api',
  };
}

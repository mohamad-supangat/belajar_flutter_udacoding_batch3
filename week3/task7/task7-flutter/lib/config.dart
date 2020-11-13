Map<String, String> config() {
  // ip 10.0.2.2 digunakan saya ketika sedang menggunakan emulator avd
  String baseUrl = 'http://10.0.2.2:8000/';

  // ip 192.168.57.1 diggunakan ketika menggunakan emulator genymotion
  // String baseUrl = 'http://192.168.57.1:8000/';

  // ip 192.168.10.121 digunakan ketika menggunakan local netwrork
  // String baseUrl = 'http://192.168.10.121:8000/';

  return {
    'baseUrl': baseUrl,
    'apiUrl': '${baseUrl}api',
  };
}

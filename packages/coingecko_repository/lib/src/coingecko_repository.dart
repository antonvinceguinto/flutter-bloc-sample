import 'package:http/http.dart' as http;

class CoinGeckoRepositoryImpl {
  CoinGeckoRepositoryImpl._();

  static final _client = http.Client();

  static final _baseUrl = 'https://api.coingecko.com/api/v3';

  static Future<http.Response> get(String path) async {
    return _client.get(Uri.parse('$_baseUrl$path'));
  }
}

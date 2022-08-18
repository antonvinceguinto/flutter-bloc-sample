import 'dart:convert';
import 'package:coingecko_repository/models/token_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CoinGeckoRepositoryImpl {
  static final _client = http.Client();

  static const _baseUrl = 'https://api.coingecko.com/api/v3';

  static Future<http.Response> get(String path) async {
    return _client.get(Uri.parse('$_baseUrl$path'));
  }

  Future<List<TokenData>> getTokenDataList(List<String> tokenId) async {
    try {
      List<TokenData> tempList = [];

      for (var token in tokenId) {
        final res = await _getTokenData(token);
        tempList.add(res);
      }

      return tempList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<TokenData> _getTokenData(String id) async {
    try {
      final response = await get(
          '/coins/${id}?tickers=false&market_data=true&community_data=false&developer_data=false');
      final res = await compute(jsonDecode, response.body);
      return TokenData.fromJson(res);
    } catch (e) {
      throw Exception(e);
    }
  }
}

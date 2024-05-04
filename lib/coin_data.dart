import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = "your_api_key";

class CoinData {
  Future<List<String>> getExchangeRate(String? currency) async {
    List<String> rateList = List<String>.filled(3, '');
    for (int i = 0; i < cryptoList.length; i++) {
      http.Response response = await http.get(Uri.parse(
          "https://rest.coinapi.io/v1/exchangerate/${cryptoList[i]}/$currency?apikey=$apiKey&invert=true&output_format=json"));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        String rate = decodedData['rate'].toStringAsFixed(2)!;
        rateList[i] = rate;
      } else {
        print(response.statusCode);
        throw 'problem with the get request';
      }
    }
    return rateList;
  }
}

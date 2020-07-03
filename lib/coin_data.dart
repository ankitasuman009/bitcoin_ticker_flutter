//TODO: Add your imports here.
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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'ABD8AC77-ABCE-4B2E-B7E0-502365F483D3';

class CoinData {
    Future<dynamic> getCoinData(var cryptoVal , String countryCode) async {
      http.Response response = await http.get(
          '$coinAPIURL/$cryptoVal/$countryCode?apikey=$apiKey');
      if (response.statusCode == 200) {
        print('the status of the response is thisssss');
        print(response.statusCode);

        print(jsonDecode(response.body));
        return jsonDecode(response.body);
      }
      else
        print(response.statusCode);
  }
}

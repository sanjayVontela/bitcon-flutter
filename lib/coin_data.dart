import 'package:http/http.dart';
import 'dart:convert';
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

class CoinData {

    Future getPricesSelected(String currency) async {
      Uri BTCappuri = Uri.parse(
          "https://rest.coinapi.io/v1/exchangerate/BTC/$currency/?apikey=F749B5A1-DAE4-4145-92B8-979E921831F7");
      Response response = await get(BTCappuri);
      if (response.statusCode == 200) {
        // print(jsonDecode(response.body)["rate"]);
        var price = jsonDecode(response.body)["rate"];
        return price;
        // print(price);
      } else {
        print(response.statusCode);
      }
    }
  }

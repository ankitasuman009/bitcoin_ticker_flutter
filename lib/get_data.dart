import 'coin_data.dart';


class GetData{
  CoinData coinRate = CoinData();
  final List<dynamic> data = [];


  Future<int> getData(var i , var selectedCurrency) async {
      var coin = await coinRate.getCoinData(cryptoList[i], selectedCurrency);
      print(coin);
      var rateData = coin['rate'];
      var rate = rateData.toInt();
    return rate;
  }
}
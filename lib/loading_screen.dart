import 'package:bitcoin_ticker/get_data.dart';
import 'package:bitcoin_ticker/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'get_data.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  final String selectedCurrency = 'USD';
  @override


  void initState(){
    super.initState();
    print('initial');
    getDataWhileLoadling();
  }

  void getDataWhileLoadling() async {
    List<dynamic> data =[];
    GetData _getData = GetData();

    for (int i = 0; i < 3; i++){
      var _data = await _getData.getData(i, selectedCurrency);
      data.add(_data);
    }
    print(data);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return PriceScreen(data);
    }));
  }

  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.black,
          size: 80.0,
        ),
      ),
    );
  }
}


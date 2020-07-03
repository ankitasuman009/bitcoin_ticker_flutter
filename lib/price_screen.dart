import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'get_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

String selectedCurrency = 'USD';
List<dynamic> rateU = [null];

bool _spinnerStatus = false;

class PriceScreen extends StatefulWidget {
  PriceScreen(this.coinData);
  final List<dynamic> coinData;
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  GetData _getData = GetData();



  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      elevation: 5,
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (value) async {
        setState(() {
          _spinnerStatus = true;
        });
        List<dynamic> data = [];
        for (int i = 0; i < 3; i++){
          var _data = await _getData.getData(i, value);
        data.add(_data);
      }
        updateUI(data);
        setState(() {
          selectedCurrency = value;
        });
        setState(() {
          _spinnerStatus = false;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }



  @override
  void initState() {
    super.initState();
      updateUI(widget.coinData);
  }


  void updateUI(dynamic _value){
    setState(() {
      if (_value == null)
        return;
      rateU = _value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker',
        textAlign: TextAlign.center,),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _spinnerStatus,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InfoButton(0),
            InfoButton(1),
            InfoButton(2),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoButton extends StatelessWidget {
  InfoButton(this.num);
  final int num;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            //TODO: Update the Text Widget with the live bitcoin data here.
            '1 ${cryptoList[num]} = ${rateU[num]} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

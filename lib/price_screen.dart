// import 'dart:html';



import 'package:flutter/material.dart';
import 'package:bitcoin/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;


class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    exchangeRate();
  }
  String selectedCurrency = "USD";
  double? price;
  CoinData coin = CoinData();


  Widget getPicker(){
    if(Platform.isIOS){
      return IOSpicker();
    }
    else if(Platform.isAndroid){
      return androidDropDown();
    }
    else{
      return androidDropDown();
    }
  }

  DropdownButton<String> androidDropDown(){
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList.map((String currency) {
      return DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
          );
          }).toList(),
        onChanged: (value){
          setState(() {
          selectedCurrency = value??'';
          exchangeRate();
          // getPrices();
          // print(value);
        });

    });
  }

  CupertinoPicker IOSpicker(){
    List<Text> pickerItems = [];
    for (String currency in currenciesList){
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(itemExtent: 32.0, onSelectedItemChanged: (selectedIndex){
      print(selectedIndex);
    }, children: pickerItems);
  }
  String bitcoinValue = '?';

  void exchangeRate() async{
    try {
      double data = await coin.getPricesSelected(selectedCurrency);
      //13. We can't await in a setState(). So you have to separate it out into two steps.
      setState(() {
        bitcoinValue = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
        centerTitle: true,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker()
          ),
        ],
      ),
    );
  }
}


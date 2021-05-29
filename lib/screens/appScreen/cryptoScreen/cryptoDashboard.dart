import 'dart:convert';
import 'package:ewall/screens/appScreen/cryptoScreen/CoinMarket.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoDashBoard extends StatefulWidget {
  const CryptoDashBoard({Key key}) : super(key: key);

  @override
  _CryptoDashBoardState createState() => _CryptoDashBoardState();
}

class _CryptoDashBoardState extends State<CryptoDashBoard> {
  var list;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> refreshListCoins() async {
    refreshKey.currentState?.show(atTop: false);
    setState(() async {
      list = await fetchListCoin();
      print("This is list" + list.toString());
    });
  }

  void initState() {
    super.initState();
    refreshListCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto DashBoard"),
      ),
      body: Center(
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshListCoins,
          child: FutureBuilder<List<CoinMarket>>(
            future: list,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == null) {
                print('project snapshot data is: ${snapshot.data}');
              } else if (snapshot.hasData) {
                print("Has Data");
                List<CoinMarket> coins = snapshot.data.toList();
                return ListView.builder(
                  itemCount: coins.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${coins[index]}'),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                Text('Error Loading:');
              }
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<List<CoinMarket>> fetchListCoin() async {
  final response = await http.get(
      Uri.parse(
          'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'),
      headers: {
        'X-CMC_PRO_API_KEY': '935f2ea4-7405-4ca5-a5c6-f1b07639ed4f',
        "Accept": "application/json",
      });
  print("hello");
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    print("This is repsonse " + map.toString());
    List<dynamic> data = map['data'] as List;
    print("This is data" + data.toString());
    print(data.map((e) => new CoinMarket.fromJson(e)).toList());
    return data.map((e) => new CoinMarket.fromJson(e)).toList();
  } else {
    throw Exception('Failed To Load Coin Market Data');
  }
}

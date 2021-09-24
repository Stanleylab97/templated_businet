import 'package:flutter/material.dart';

import '../component.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _telephoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: SafeArea(
            child: appBar(
                left: Icon(Icons.notes, color: Colors.black54),
                title: 'Investisseurs',
                right:
                    Icon(Icons.account_balance_wallet, color: Colors.black54)),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Placeholder()),
                    );
                  },
                  child: _cardWalletBalance(context,
                      total: '\XOF 7.939.589',
                      totalCrypto: '7.251332 BTC',
                      precent: 7.999),
                ),
              ]),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dernières transactions',
                      style: TextStyle(color: Colors.black45)),
                  Row(children: [
                    Text(
                      '|',
                      style: TextStyle(color: Colors.black45),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.black45),
                  ])
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _listCryptoItem(
                        iconUrl:
                            'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Bitcoin-icon.png',
                        myCrypto: '23.000 XOF',
                        myBalance: '\$ 5.441',
                        myProfit: '\$19.153',
                        precent: 4.32,
                      ),
                      _listCryptoItem(
                        iconUrl:
                            'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ethereum-icon.png',
                        myCrypto: '150.000 XOF',
                        myBalance: '\$ 401',
                        myProfit: '\$4.822',
                        precent: 6.97,
                      ),
                      _listCryptoItem(
                        iconUrl:
                            'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ripple-icon.png',
                        myCrypto: '163.500 XOF',
                        myBalance: '\$ 0.45',
                        myProfit: '\$859',
                        precent: 0.55,
                      ),
                      _listCryptoItem(
                        iconUrl:
                            'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ripple-icon.png',
                        myCrypto: '260.000 XOF',
                        myBalance: '\$ 0.45',
                        myProfit: '\$859',
                        precent: 1.55,
                      ),
                      _listCryptoItem(
                        iconUrl:
                            'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ripple-icon.png',
                        myCrypto: '30.000 XOF',
                        myBalance: '\$ 0.45',
                        myProfit: '35.000 XOF',
                        precent: 2.55,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _cardWalletBalance(BuildContext context,
      {String total, totalCrypto, double precent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: card(
        width: MediaQuery.of(context).size.width - 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.black87,
                    child: InkWell(
                      splashColor: Colors.red, // inkwell color
                      child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white,
                            size: 25.0,
                          )),
                      onTap: () {},
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text('Solde du portefeuille',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Row(
                  children: [Text('XOF'), Icon(Icons.money)],
                )
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$total',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                      color: precent >= 0 ? Colors.green : Colors.pink,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: InkWell(
                    child: Text(
                      'Charger',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Montant à investir',
                                  textAlign: TextAlign.center),
                              content: TextField(
                                controller: _telephoneController,
                                textInputAction: TextInputAction.go,
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration:
                                    InputDecoration(hintText: "Ex: 15000"),
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text('Continuer'),
                                  onPressed: () {
                                    _telephoneController.clear();
                                    Navigator.of(context).pop();

                                    /*  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Placeholder() // ValidatedProjectDetails(doc: doc),
                                          ),
                                    ); */
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                )
              ],
            ),
            Center(
              child: Icon(Icons.keyboard_arrow_down,
                  size: 30, color: Colors.black45),
            )
          ],
        ),
      ),
    );
  }

  Widget _listCryptoItem(
      {String iconUrl,
      double precent = 0,
      String myCrypto,
      myBalance,
      myProfit}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              '$iconUrl',
              width: 50,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '$myCrypto',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    '$myProfit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /*  Text(
                                          '$myBalance',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        ), */
                Text(
                  precent >= 0 ? '+ $precent %' : '$precent %',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: precent >= 0 ? Colors.green : Colors.pink,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

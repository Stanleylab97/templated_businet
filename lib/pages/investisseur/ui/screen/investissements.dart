import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:news_app/pages/investisseur/ui/component/transaction.dart'
    as tr;

class Investissements extends StatefulWidget {
  const Investissements();

  @override
  _InvestissementsState createState() => _InvestissementsState();
}

class _InvestissementsState extends State<Investissements> {
  var transactionHeading = Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 5,
    ).copyWith(
      top: 5,
      bottom: 5,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Transactions',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF151C2A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  /*var transactions = Expanded(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Transactions")
              /* .where('useruid',
                              isEqualTo: FirebaseAuth.instance.currentUser.uid) */
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                  'Veuillez réessayer plus tard. Un léger soucis de connexion');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text('Pas de projets validés en attentes'),
              );
            }
            print("User uid: ${FirebaseAuth.instance.currentUser.uid}");
            print("Transac: ${snapshot.data.docs[0]['useruid']}");
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, index) {
                  return tr.TransactionItem(tr.Transaction(
                      idTransaction: snapshot.data.docs[index]['idTransaction'],
                      loadedAmount: snapshot.data.docs[index]['loadedAmount'],
                      transactionTime:
                          snapshot.data.docs[index]['transactionTime'].toDate(),
                      newSolde: snapshot.data.docs[index]['newSolde'],
                      lastSolde: snapshot.data.docs[index]['lastSolde']));
                });
          })); */

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Historique des opérations',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _buildRegionTabBar() {
    /* return TabBar(
      indicator: BubbleTabIndicator(
        tabBarIndicatorSize: TabBarIndicatorSize.tab,
        indicatorHeight: 40.0,
        indicatorColor: Colors.white,
      ),
      labelStyle: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.white,
      tabs: <Widget>[
        Text('Transactions'),
        Text('Investissements'),
      ],
      onTap: (index) {},
    ); */
    /*  ),
      ),
    ); */
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              iconSize: 28.0,
              onPressed: () {},
            ),
            title: Text(
              'Historique des opérations',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                      child: TabBar(
                        indicator: BubbleTabIndicator(
                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          indicatorHeight: 40.0,
                          indicatorColor: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.white,
                        tabs: <Widget>[
                          Text('Transactions'),
                          Text('Investissements'),
                        ],
                      ))),
              SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * .604,
                child: TabBarView(
                  children: [
                    Expanded(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Transactions")
                                /* .where('useruid',
                              isEqualTo: FirebaseAuth.instance.currentUser.uid) */
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Veuillez réessayer plus tard. Un léger soucis de connexion');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.data.docs.length == 0) {
                                return Center(
                                  child: Text(
                                      'Pas de projets validés en attentes'),
                                );
                              }
                              print(
                                  "User uid: ${FirebaseAuth.instance.currentUser.uid}");
                              print(
                                  "Transac: ${snapshot.data.docs[0]['useruid']}");
                              return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return tr.TransactionItem(tr.Transaction(
                                        idTransaction: snapshot.data.docs[index]
                                            ['idTransaction'],
                                        loadedAmount: snapshot.data.docs[index]
                                            ['loadedAmount'],
                                        transactionTime: snapshot
                                            .data.docs[index]['transactionTime']
                                            .toDate(),
                                        newSolde: snapshot.data.docs[index]
                                            ['newSolde'],
                                        lastSolde: snapshot.data.docs[index]
                                            ['lastSolde']));
                                  });
                            })),
                    Expanded(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Investissements")
                                /* .where('useruid',
                              isEqualTo: FirebaseAuth.instance.currentUser.uid) */
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Veuillez réessayer plus tard. Un léger soucis de connexion');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.data.docs.length == 0) {
                                return Center(
                                  child: Text(
                                      'Pas de projets validés en attentes'),
                                );
                              }
                              print(
                                  "User uid: ${FirebaseAuth.instance.currentUser.uid}");
                              print(
                                  "Invest: ${snapshot.data.docs[0]['montant']}");
                              return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return tr.investissement(
                                      nomProjet: snapshot.data.docs[index]
                                          ['nomProjet'],
                                      amount: snapshot.data.docs[index]
                                          ['montant'],
                                      dateInvestissement: snapshot.data
                                          .docs[index]['dateInvestissement']
                                          .toDate(),
                                    );
                                  });
                            }))
                  ],
                ),
              )
            ]),
          )),
    );

    /* Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Transactions")
                      /* .where('useruid',
                              isEqualTo: FirebaseAuth.instance.currentUser.uid) */
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          'Veuillez réessayer plus tard. Un léger soucis de connexion');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.data.docs.length == 0) {
                      return Center(
                        child: Text('Pas de projets validés en attentes'),
                      );
                    }
                    print("User uid: ${FirebaseAuth.instance.currentUser.uid}");
                    print("Transac: ${snapshot.data.docs[0]['useruid']}");
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, index) {
                          return tr.TransactionItem(tr.Transaction(
                              idTransaction: snapshot.data.docs[index]
                                  ['idTransaction'],
                              loadedAmount: snapshot.data.docs[index]
                                  ['loadedAmount'],
                              transactionTime: snapshot
                                  .data.docs[index]['transactionTime']
                                  .toDate(),
                              newSolde: snapshot.data.docs[index]['newSolde'],
                              lastSolde: snapshot.data.docs[index]
                                  ['lastSolde']));
                        });
                  })) */

    // backgroundColor: Colors.white,
  }
}

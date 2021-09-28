import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'package:news_app/pages/investisseur/ui/component/card.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(size.width * 0.03).copyWith(bottom: 0),
      child: Row(
        children: <Widget>[
          Container(
            height: size.width * .15,
            width: size.width * .15,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(207, 236, 248, 0.50),
                    blurRadius: 24,
                    offset: Offset(0, size.width * 0.002),
                  )
                ]),
            child: Center(
              child: Icon(
                Icons.download_rounded,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.0001),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'Muli'),
                  children: [
                    TextSpan(
                      text: '${this.transaction.newSolde.toString()} F CFA\n',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF151C2A),
                      ),
                    ),
                    TextSpan(
                      text: this.transaction.lastSolde.toString() + ' F CFA',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF7E8EAA),
                      ).copyWith(height: 1.5),
                    )
                  ],
                ),
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              style: TextStyle(fontFamily: 'Muli'),
              children: [
                /*    TextSpan(
                  text:
                      '${this.transaction.value.isNegative ? '-' : '+'}\$${this.transaction.value}\n',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    color: Color(0xFF151C2A),
                  ).copyWith(
                    fontWeight: FontWeight.w600,
                    color: this.transaction.value.isNegative
                        ? Color(0xFFEE6B8D)
                        : Color(0xFF30C96B),
                  ),
                ), */
                TextSpan(
                  text: this.transaction.transactionTime.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF7E8EAA),
                  ).copyWith(height: 1.5),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget investissement({
  String nomProjet,
  int amount,
  DateTime dateInvestissement,
}) {
  final f = new DateFormat('dd-MM-yyyy');
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$amount' + 'F CFA',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${f.format(dateInvestissement)}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ]),
                Text(
                  'Projet :$nomProjet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
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
            ],
          ),
        ],
      ),
    ),
  );
}

class Transaction {
  final int loadedAmount;
  final int lastSolde;
  final int newSolde;
  final DateTime transactionTime;
  final int idTransaction;

  Transaction(
      {this.idTransaction,
      this.loadedAmount,
      this.lastSolde,
      this.newSolde,
      this.transactionTime});
}

class Investissement {
  final int amount;
  final String nomProjet;
  final DateTime dateInvestissement;

  Investissement({
    this.nomProjet,
    this.amount,
    this.dateInvestissement,
  });
}

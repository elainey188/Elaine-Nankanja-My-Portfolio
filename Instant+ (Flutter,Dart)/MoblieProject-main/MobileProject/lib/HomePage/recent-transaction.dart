import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Classes/overall.dart';
import '../Classes/transaction.dart';

/*
TODO:
- UI Layout
- Recent Transactions are displayed in a draggable sheet
- Each transaction is a ListTile
-Populate with data
 */

class RecentTransactions extends StatelessWidget {

  // TODO: TO BE REMOVED
  // static List<Map<String, dynamic>> getTransactions() {
  //   return [
  //     {
  //       'type': 'Deposited',
  //       'amount': 100.01,
  //       'date': DateTime.now().subtract(Duration(days: 30)),
  //       'time': '3:24pm',
  //     },
  //     {
  //       'type': 'Withdrawn',
  //       'amount': -100.00,
  //       'date': DateTime.now().subtract(Duration(days: 60)),
  //       'time': '4:15pm',
  //     },
  //     // Add more transactions here
  //   ];
  // }

  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final overall = Provider.of<Overall>(context);

    String currentDayMonthYear = overall.getCurrentDayMonthYear();
    List<Transaction> transactions = overall.getTransactions();

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.7,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Color(0xFF111735),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          currentDayMonthYear,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: transactions.length,
                        itemBuilder: (BuildContext context, int index) {
                          var transaction = transactions[index];
                          return ListTile(
                            leading: Icon(
                              transaction.getTransactionType() == 'Deposit' ? Icons.arrow_downward : Icons.arrow_upward,
                              color: Colors.white,
                            ),
                            title: Text(
                              transaction.getTransactionType(),
                              style: const TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            subtitle: Text(
                              transaction.getTransactionDate(),
                              style: const TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  transaction.getTransactionType() == 'Deposit'
                                      ? '+\$${transaction.getAmount().toStringAsFixed(2)}'
                                      : '-\$${transaction.getAmount().abs().toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  transaction.getTransactionTime(),
                                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

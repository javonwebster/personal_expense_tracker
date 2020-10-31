import 'package:flutter/material.dart';
import './transaction_item.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    //height: 300,
    //think of list view as a column (or row) with a built in SingleChildScrollView
    //a listView does not have a fixed height (height is infinite). So we need to give
    //it some contraints- height: 300
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  "No transactions added yet!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                //we had to wrap the image in a container so it could use those boundaries.
                Container(
                  // height: 200,
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                  //ValueKey takes a key so that the generated key is always the same when it's rebuilt
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTx: deleteTx,
                    ))
                .toList(),
          );
    // : ListView.builder(
    //     //item builder is called for every item in the list
    //     itemBuilder: (context, index) {
    //       //UniqueKey() - creates a new key for every items
    //       return TransactionItem(key: ValueKey(transactions[index].id), transaction: transactions[index], deleteTx: deleteTx); //there is a but in ListView when it comes to Keys
    //     },
    //     //defines how many items should be built
    //     itemCount: transactions.length,
    //   );
  }
}

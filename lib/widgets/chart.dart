import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      //this function is excecuted for every list element
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        "day":
            DateFormat.E().format(weekDay).substring(0, 1), //to get first char
        "amount": totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    //fold allows us to take a list and convert it to another type using a function
    //that we define. For example taking a list of sums to make one large total sum.
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        //the widget padding is a replacement for container IF the only thing you are customizing is the padding
        padding: EdgeInsets.all(10),
        child: Row(
          //to space out charts
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //mapping a list of widgets
          children: groupedTransactionValues.map((data) {
            //we use FlexFit.tight so that when the number of is long it doesn't widden the column its in and it stays consistent
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

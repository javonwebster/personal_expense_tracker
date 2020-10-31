import 'package:flutter/foundation.dart';

class Transaction {
  //add "final" to make them runtime contants
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({@required this.id,@required this.title,@required this.amount,@required this.date});
}

import 'package:flutter/material.dart';
import 'dart:math';

import 'data.dart';

class Account {
  final Currency currency;
  final double balance;
  final List<Transaction> _transactions;

  Account(this.currency, this.balance, this._transactions);
  factory Account.template() {
    return Account(Currency.USD, 1533.21, Repository.transactions);
  }

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction t) => _transactions.add(t);
  void removeTransaction(Transaction t) => _transactions.remove(t);
  void clearTransactions() => _transactions.clear();
}

class Transaction {
  final String name;
  final double amount;
  final bool isIncome;
  final Currency currency;
  final ImageProvider<Object>? imageProvider;
  final DateTime date;

  Transaction(
    this.name,
    this.amount, {
    this.isIncome = true,
    this.currency = Currency.USD,
    this.imageProvider,
  }) : date = DateTime(
          2022,
          1,
          Random().nextInt(5) + 10,
          Random().nextInt(24),
          Random().nextInt(60),
        );

  String get time => '${date.hour}:${date.minute}';
  String get month => 'Jan';
}

enum Currency {
  USD,
  RUB,
  TNG;

  String get sign {
    switch (this) {
      case USD:
        return '\$';
      case RUB:
        return 'P';
      default:
        return '?';
    }
  }

  @override
  String toString() {
    return name;
  }
}

enum DatePeriod {
  all,
  month,
  week,
  day,
  custom;

  static List<String> get dropdownValues =>
      values.map((e) => e.name).take(values.length - 1).toList();
}

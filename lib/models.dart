import 'dart:math';

import 'data.dart';

class Account {
  final Currency currency;
  final double balance;
  final List<Transaction> _transactions;
  final String? imageSrc;

  Account(this.currency, this.balance, this._transactions, {this.imageSrc});
  factory Account.template() {
    return Account(
      Currency.USD,
      1533.21,
      Repository.transactions,
      imageSrc: 'usa_flag.png',
    );
  }

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction t) => _transactions.add(t);
  void removeTransaction(Transaction t) => _transactions.remove(t);
  void clearTransactions() => _transactions.clear();
}

class Transaction {
  final String accountName;
  final double amount;
  final bool isIncome;
  final Currency currency;
  final String? imageSrc;
  final DateTime date;

  Transaction(
    this.accountName,
    this.amount, {
    this.isIncome = true,
    this.currency = Currency.USD,
    this.imageSrc,
  }) : date = DateTime(
          2022,
          1,
          1 + Random().nextInt(5),
          Random().nextInt(24),
          Random().nextInt(60),
        );

  static const String defaultMonth = 'Jan';

  String get time => '${date.hour}:${date.minute}';
  String get month => defaultMonth;
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

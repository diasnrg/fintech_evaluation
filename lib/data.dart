import 'dart:math';

import 'models.dart';

class Repository {
  static List<Transaction>? _transactions;

  static List<Transaction> get transactions {
    _transactions ??= _generateRandomTransactions();
    _transactions!.sort((a, b) => a.date.compareTo(b.date));
    return _transactions!;
  }

  static List<Transaction> _generateRandomTransactions() {
    const itemsCount = 20;
    final random = Random();
    return List.generate(
      itemsCount,
      (index) {
        final double r = random.nextInt(100).toDouble();
        final String name;
        if (r % 3 == 0) {
          name = 'McDonalds';
        } else if (r % 4 == 0) {
          name = 'Nike';
        } else {
          name = 'Starbucks';
        }

        return Transaction(name, r * index, isIncome: r % 2 == 0);
      },
    );
  }
}

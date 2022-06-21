import 'dart:math';

import 'models.dart';

class Repository {
  static List<Transaction>? _transactions;

  static List<Transaction> get transactions {
    _transactions ??= _generateRandomTransactions();
    _transactions!.sort((a, b) => b.date.compareTo(a.date));
    return _transactions!;
  }

  static List<Transaction> _generateRandomTransactions() {
    const itemsCount = 20;
    final random = Random();
    return List.generate(
      itemsCount,
      (_) {
        final double randomValue = random.nextInt(1000).toDouble();
        final String accountName;
        final String imageSrc;
        if (randomValue % 3 == 0) {
          accountName = 'McDonalds';
          imageSrc = 'mc.png';
        } else if (randomValue % 3 == 1) {
          accountName = 'Nike';
          imageSrc = 'nike.jpeg';
        } else {
          accountName = 'Starbucks';
          imageSrc = 'starbucks.png';
        }

        return Transaction(
          accountName,
          randomValue,
          isIncome: randomValue % 2 == 0,
          imageSrc: imageSrc,
        );
      },
    );
  }
}

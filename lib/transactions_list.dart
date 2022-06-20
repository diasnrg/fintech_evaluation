import 'package:flutter/material.dart';

import 'models.dart';

class TransactionsListView extends StatelessWidget {
  const TransactionsListView({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    final transactions = account.transactions;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          bool showDividerByDate = needToShowDividerByDay(index);

          return Column(
            children: [
              if (showDividerByDate)
                DividerByDay(
                  date:
                      '${transactions[index].month}, ${transactions[index].date.day}',
                ),
              TransactionItemView(
                transaction: transactions[index],
              ),
              if (index != transactions.length)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black12,
                ),
            ],
          );
        },
        childCount: transactions.length,
      ),
    );
  }

  bool needToShowDividerByDay(int index) {
    return index == 0 ||
        (index + 1 < account.transactions.length &&
            account.transactions[index].date.day !=
                account.transactions[index + 1].date.day);
  }
}

class TransactionItemView extends StatelessWidget {
  const TransactionItemView({super.key, required this.transaction});
  final Transaction transaction;
  final boldTextStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    final amount =
        '${(transaction.isIncome ? '+' : '-')} ${transaction.currency.sign}${transaction.amount.toStringAsFixed(2)} ${transaction.currency}';

    return ListTile(
      leading: CircleAvatar(radius: 18, child: Text(transaction.name[0])),
      title: Text(transaction.name, style: boldTextStyle),
      subtitle: Text(transaction.time),
      trailing: Text(amount, style: boldTextStyle),
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    );
  }
}

class DividerByDay extends StatelessWidget {
  const DividerByDay({super.key, this.date = 'Today'});
  final String date;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(date),
      tileColor: Colors.black12,
    );
  }
}

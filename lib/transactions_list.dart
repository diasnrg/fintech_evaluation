import 'package:flutter/material.dart';

import 'models.dart';

class TransactionsListView extends StatelessWidget {
  const TransactionsListView({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    if (account.transactions.isEmpty) {
      return _emptyState;
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final bool showDividerByDate = needToShowDividerByDay(index);
          final currentTransaction = account.transactions[index];

          return Column(
            children: [
              if (showDividerByDate)
                DividerByDay(
                  date:
                      '${currentTransaction.month}, ${currentTransaction.date.day}',
                ),
              TransactionItemView(
                transaction: currentTransaction,
              ),
              if (index != account.transactions.length)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black12,
                ),
            ],
          );
        },
        childCount: account.transactions.length,
      ),
    );
  }

  Widget get _emptyState {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 128,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Transactions history is empty.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  bool needToShowDividerByDay(int index) {
    return index == 0 ||
        index > 0 &&
            account.transactions[index - 1].date.day !=
                account.transactions[index].date.day;
  }
}

class TransactionItemView extends StatelessWidget {
  const TransactionItemView({super.key, required this.transaction});
  final Transaction transaction;
  final TextStyle boldTextStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    final String amount =
        '${(transaction.isIncome ? '+' : '-')} ${transaction.currency.sign}${transaction.amount.toStringAsFixed(2)} ${transaction.currency}';
    final bool hasImage = transaction.imageSrc != null;

    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        foregroundImage: hasImage
            ? Image.asset('assets/images/${transaction.imageSrc!}').image
            : null,
        child: !hasImage ? Text(transaction.accountName[0]) : null,
      ),
      title: Text(transaction.accountName, style: boldTextStyle),
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

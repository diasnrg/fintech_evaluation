import 'package:flutter/material.dart';

import 'account_header.dart';
import 'transactions_filter.dart';
import 'transactions_list.dart';
import 'models.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: AccountView()),
    );
  }
}

class AccountView extends StatelessWidget {
  AccountView({super.key});
  final Account account = Account.template();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AccountHeaderView(account: account),
        ),
        const SliverToBoxAdapter(child: TransactionsFilterView()),
        TransactionsListView(account: account),
      ],
    );
  }
}

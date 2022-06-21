import 'package:flutter/material.dart';

import 'models.dart';

class AccountHeaderView extends StatefulWidget {
  const AccountHeaderView({super.key, required this.account});
  final Account account;

  @override
  State<AccountHeaderView> createState() => AccountHeaderViewState();
}

class AccountHeaderViewState extends State<AccountHeaderView> {
  late bool balanceIsHidden;
  late final Account account;

  static const String balanceHiddenValue = '\$ XXX.XX';

  @override
  void initState() {
    super.initState();
    balanceIsHidden = false;
    account = widget.account;
  }

  @override
  Widget build(BuildContext context) {
    double side = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          height: side,
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 36,
                foregroundImage:
                    Image.asset('assets/images/${account.imageSrc}').image,
              ),
              const SizedBox(height: 16),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  const SizedBox(width: double.infinity),
                  Text(
                    '${account.currency} Account',
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  Positioned(
                    right: 12,
                    child: HideButton(
                      onTap: () =>
                          setState(() => balanceIsHidden = !balanceIsHidden),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                balanceIsHidden
                    ? balanceHiddenValue
                    : '${account.currency.sign} ${account.balance}',
                style: const TextStyle(color: Colors.white, fontSize: 28),
              ),
            ],
          ),
        ),
        const PositionedAppBar(),
      ],
    );
  }
}

class PositionedAppBar extends StatelessWidget {
  const PositionedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: 48,
      left: 24,
      right: 24,
      child: SizedBox(
        width: screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            Icon(
              Icons.ios_share,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class HideButton extends StatelessWidget {
  const HideButton({super.key, this.onTap, this.isHidden = false});
  final VoidCallback? onTap;
  final bool isHidden;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Text(isHidden ? 'Show' : 'Hide',
            style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'models.dart';

const Color textColor = Colors.white70;
const Color borderColor = Colors.white24;
const double borderRadius = 12;

class TransactionsFilterView extends StatefulWidget {
  const TransactionsFilterView({super.key});

  @override
  State<TransactionsFilterView> createState() => TransactionsFilterViewState();
}

class TransactionsFilterViewState extends State<TransactionsFilterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 14, 14, 16),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transactions History',
            style: TextStyle(color: textColor, fontSize: 18),
          ),
          const SizedBox(height: 16),
          const CurrencyDropdown(),
          const SizedBox(height: 16),
          Row(
            children: const [
              DatePeriodDropdown(),
              SizedBox(width: 16),
              Calendar(),
            ],
          ),
        ],
      ),
    );
  }
}

class CurrencyDropdown extends StatelessWidget {
  const CurrencyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
        values: Currency.values.map((c) => c.toString()).toList());
  }
}

class DatePeriodDropdown extends StatelessWidget {
  const DatePeriodDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CustomDropdown(
      values: DatePeriod.dropdownValues.toList(),
    ));
  }
}

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key, required this.values});
  final List<String> values;

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.values.isNotEmpty ? widget.values[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        onChanged: (String? newValue) =>
            setState(() => dropdownValue = newValue),
        items: _items,
        icon: _arrowIcon,
        dropdownColor: Colors.black87,
        isExpanded: true,
        underline: const SizedBox.shrink(),
      ),
    );
  }

  List<DropdownMenuItem<String>> get _items {
    return widget.values
        .map((value) => DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: textColor),
            )))
        .toList();
  }

  Widget get _arrowIcon {
    return Transform.scale(
      scale: 0.6,
      child: Transform.rotate(
        angle: -math.pi / 2,
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: textColor,
        ),
      ),
    );
  }
}

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: const Icon(
        Icons.calendar_today_outlined,
        color: textColor,
      ),
    );
  }
}

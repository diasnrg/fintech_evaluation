import 'package:flutter/material.dart';

import 'models.dart';

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
            'Transactions history',
            style: TextStyle(color: Colors.white, fontSize: 16),
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
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        onChanged: (String? newValue) =>
            setState(() => dropdownValue = newValue),
        items: widget.values
            .map(
              (value) => DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            )
            .toList(),
        dropdownColor: Colors.black87,
        isExpanded: true,
        underline: const SizedBox.shrink(),
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
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(12)),
      child: const Icon(
        Icons.calendar_month,
        color: Colors.white,
      ),
    );
  }
}

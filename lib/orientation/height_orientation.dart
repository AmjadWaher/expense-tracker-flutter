import 'dart:io';

import 'package:expensetracker/model/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeightOrientation extends StatefulWidget {
  const HeightOrientation({super.key, required this.addExpense});
  final void Function(Expense) addExpense;
  @override
  State<HeightOrientation> createState() {
    return _HeightOrientationState();
  }
}

class _HeightOrientationState extends State<HeightOrientation> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.leisure;
  DateTime? _selectedDate;

  void _calendar() async {
    final now = DateTime.now();
    final past = DateTime(now.year - 1, 1, 1);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: past,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog(bool isInvalidTitle, bool isInvalidAmount) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: isInvalidTitle
              ? const Text('Please make sure the title is correct...')
              : isInvalidAmount
                  ? const Text('Please make sure the amount is correct...')
                  : const Text('Please make sure the date is correct...'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      // to show Error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: isInvalidTitle
              ? const Text('Please make sure the title is correct...')
              : isInvalidAmount
                  ? const Text('Please make sure the amount is correct...')
                  : const Text('Please make sure the date is correct...'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _messageError() {
    final amount = double.tryParse(_amountController.text);
    // (trim) to remove white space
    final isInvalidTitle = _titleController.text.trim().isEmpty;
    final isInvalidAmount = amount == null || amount <= 0;
    if (isInvalidTitle || _selectedDate == null || isInvalidAmount) {
      _showDialog(isInvalidTitle, isInvalidAmount);
    }

    widget.addExpense(
      Expense(
        title: _titleController.text,
        amount: amount!,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          // onChanged: _saveTitleInput,
          controller: _titleController,
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text('Title'),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  label: Text('Amount'),
                  prefixText: '\$ ',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Selected Date'
                        : formatter.format(_selectedDate!),
                  ),
                  IconButton(
                    onPressed: _calendar,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                }),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _messageError();
                Navigator.pop(context);
              },
              child: const Text('Save Expense'),
            ),
          ],
        )
      ],
    );
  }
}

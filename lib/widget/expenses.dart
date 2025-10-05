import 'package:expensetracker/start/switch_button.dart';
import 'package:expensetracker/widget/ExpensesList/expenses_list.dart';
import 'package:expensetracker/model/expense.dart';
import 'package:expensetracker/widget/chart/chart.dart';
import 'package:expensetracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({required this.switchMode, super.key});
  final void Function(bool) switchMode;

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _selectedExpense = [];

  void addExpense(Expense expense) {
    setState(() {
      _selectedExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _selectedExpense.indexOf(expense);
    setState(() {
      _selectedExpense.remove(expense);
    });

    // It is used because of the possibility of deleting more than one card
    // The immediately previous message disappears to display the new message
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('${expense.title} deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _selectedExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpense() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(addExpense: addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Used to know the width of the device
    final width = MediaQuery.of(context).size.width;

    Widget mainCotent = const Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (_selectedExpense.isNotEmpty) {
      mainCotent = ExpensesList(
        expensesList: _selectedExpense,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Expenses Tracker'),
          actions: [
            SwitchButton(onSwitchMode: widget.switchMode),
            IconButton(
              onPressed: _openAddExpense,
              icon: const Icon(Icons.add),
            ),
          ],
          foregroundColor: Colors.white,
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _selectedExpense),
                  Expanded(
                    child: mainCotent,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(expenses: _selectedExpense),
                  ),
                  Expanded(
                    child: mainCotent,
                  ),
                ],
              ));
  }
}

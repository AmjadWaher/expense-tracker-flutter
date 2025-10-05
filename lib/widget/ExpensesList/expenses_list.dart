import 'package:expensetracker/model/expense.dart';
import 'package:expensetracker/widget/ExpensesList/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expensesList, required this.onRemoveExpense});
  final List<Expense> expensesList;
  final void Function(Expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    // (ListView) Used when you have lists of unlimited length
    // and you get a scrollable list
    //(builder) Create a scrollable list when it is visible or about to be visible
    return ListView.builder(
      //(itemCount) Used to know how many items to display
        itemCount: expensesList.length,
        itemBuilder: (ctx, index) {
          // (Dismissible) allow to remove card
          return Dismissible(
            // (key) used to be ensure the correct data is removed
            key: ValueKey(expensesList[index]),
            onDismissed: (direction) {
              onRemoveExpense(expensesList[index]);
            },
            background: Container(
              color: Colors.red,
              child: const Icon(Icons.delete),
            ),
            child: ExpenseItem(expensesList[index]),
          );
        });
  }
}

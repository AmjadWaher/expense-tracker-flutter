import 'package:expensetracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // (Card) creates a material design card
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              children: [
                // (toStringAsFixed) Specifies the number of digits after the comma
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                //(spacer) Creates a flexible space to insert into a [flexible] widget
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      getCategoryIcon[expense.category],
                      size: 26,
                    ),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

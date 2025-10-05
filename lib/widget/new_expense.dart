import 'package:expensetracker/model/expense.dart';
import 'package:expensetracker/orientation/height_orientation.dart';
import 'package:expensetracker/orientation/width_orientation.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});
  final void Function(Expense) addExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: 450,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, keyboardSpace + 16),
            child: width >= 600
                ? WidthOrientation(addExpense: widget.addExpense)
                : HeightOrientation(addExpense: widget.addExpense),
          ),
        ),
      );
    });
  }
}

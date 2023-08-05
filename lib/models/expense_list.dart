import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onremoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onremoveExpense;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(horizontal:
          Theme.of(context).cardTheme.margin!.horizontal,),
        ),
          key: ValueKey(expenses[index]), 
          onDismissed: (direction) {
            onremoveExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index])),
    );
  }
}

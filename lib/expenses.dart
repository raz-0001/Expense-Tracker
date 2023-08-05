import 'package:expense_tracker/chart/chart.dart';
import 'package:expense_tracker/models/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Books",
        amount: 900,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Cinema",
        amount: 1000,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense:addExpense));
  }

  void addExpense(Expense expense){
    setState(() {
          _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense){
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(duration: const Duration(seconds: 2),
      content: const Text("Expense Deleted"),
      action: SnackBarAction(label: "Undo", onPressed: (){
        setState(() {
          _registeredExpenses.insert(expenseIndex, expense);
        });
      }
      ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    Widget maincontent=const Center(child: Text("No Expense found! Please Add."),);

    if(_registeredExpenses.isNotEmpty){
        maincontent=ExpensesList(expenses: _registeredExpenses,onremoveExpense: removeExpense,);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width<600?Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: maincontent,
          )
        ],
      ):
      Row(
        children: [
          Expanded(child: 
          Chart(expenses: _registeredExpenses)),
          Expanded(
            child: maincontent,
          )
        ],
      ),
    );
  }
}

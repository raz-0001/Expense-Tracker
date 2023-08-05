import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final enteredTitle = TextEditingController();
  final enteredAmount = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  void presentDatePicker() async {
    final date = DateTime.now();
    final fDate = DateTime(date.year - 1, date.month, date.day);

    final dateChosen = await showDatePicker(
        context: context, initialDate: date, firstDate: fDate, lastDate: date);

    setState(() {
      selectedDate = dateChosen;
    });
  }

  void submitData() {
    final amt = double.tryParse(enteredAmount.text);
    final inValidamt = amt == null || amt <= 0;
    if (inValidamt ||
        enteredTitle.text.trim().isEmpty ||
        selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text("Please re-enter valid details."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"))
                ],
              ));
      return;
    }

    widget.onAddExpense(Expense(
        title: enteredTitle.text,
        amount: amt,
        date: selectedDate!,
        category: selectedCategory));

        Navigator.pop(context);
  }

  @override
  void dispose() {
    enteredTitle.dispose();
    enteredAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: enteredTitle,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(children: [
            Expanded(
              child: TextField(
                controller: enteredAmount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    prefixText: "₹ ", label: Text("Amount")),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(selectedDate == null
                    ? "No Date"
                    : formatter.format(selectedDate!)),
                IconButton(
                    onPressed: presentDatePicker,
                    icon: const Icon(Icons.calendar_month_outlined))
              ],
            )
            )
          ]),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    submitData();
                  },
                  child: const Text("Save Expense")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          ),
        ],
      ),
    );
  }
}

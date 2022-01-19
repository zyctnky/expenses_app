import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction_category.dart';
import '../data/dummy_data.dart';

class TransactionNew extends StatefulWidget {
  final Function _addTransaction;

  TransactionNew(this._addTransaction);

  @override
  State<TransactionNew> createState() => _TransactionNewState();
}

class _TransactionNewState extends State<TransactionNew> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  String _selectedCategoryId;

  void _submitData() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isEmpty ||
        amount <= 0 ||
        _selectedDate == null ||
        _selectedCategoryId == null) return;

    widget._addTransaction(title, amount, _selectedDate, _selectedCategoryId);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  List<DropdownMenuItem<String>> get _transactionCategories {
    return DUMMY_CATEGORIES
        .map(
          (e) => DropdownMenuItem(
            child: Row(
              children: [
                Icon(e.icon),
                SizedBox(
                  width: 10,
                ),
                Text(e.title),
              ],
            ),
            value: e.id,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DropdownButtonFormField(
              value: _selectedCategoryId,
              items: _transactionCategories,
              onChanged: (id) {
                setState(() {
                  _selectedCategoryId = id;
                });
              },
              hint: Text("Select A Category"),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Price'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No Date Chosen"
                          : DateFormat.yMMMd().format(_selectedDate),
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Chose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            )
          ],
        ),
      ),
    );
  }
}

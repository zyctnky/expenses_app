import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/dummy_data.dart';

class FilterTransaction extends StatefulWidget {
  final Function _filter;

  FilterTransaction(this._filter);

  @override
  _FilterTransactionState createState() => _FilterTransactionState();
}

class _FilterTransactionState extends State<FilterTransaction> {
  final _dateController = TextEditingController();
  DateTime _selectedDate;
  String _selectedCategoryId;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat.yMMMd().format(pickedDate);
      });
    });
  }

  void _getAllTransactions() {
    widget._filter(null, null, true);
    setState(() {
      _dateController.text = "";
      _selectedDate = null;
      _selectedCategoryId = null;
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
    return Drawer(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                "Filter Transactions",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            TextField(
              onTap: _presentDatePicker,
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Select Date'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButton(
                    value: _selectedCategoryId,
                    items: _transactionCategories,
                    hint: Text("Select A Category"),
                    isExpanded: true,
                    iconSize: 32,
                    onChanged: (id) {
                      setState(() {
                        _selectedCategoryId = id;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => widget._filter(
                        _selectedDate, _selectedCategoryId, true),
                    child: Text(
                      "Filter",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _getAllTransactions,
                    child: Text(
                      "Get All",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/data/dummy_data.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

import '../models/transaction_category.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction _transaction;
  final Function _removeTransaction;

  const TransactionListItem(this._transaction, this._removeTransaction);

  TransactionCategory get _category {
    return DUMMY_CATEGORIES
        .firstWhere((element) => element.id == _transaction.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 5,
                  ),
                  child: Icon(
                    _category.icon,
                    color: _category.color,
                    size: 40,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _transaction.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      DateFormat.yMMMd().format(_transaction.date),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  '\$ ${_transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  color: Theme.of(context).errorColor,
                  onPressed: () => _removeTransaction(_transaction.id),
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}

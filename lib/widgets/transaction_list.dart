import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_list_item.dart';

import '../widgets/transactions_empty.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _removeTransaction;

  TransactionList(this._transactions, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      child: _transactions.isEmpty
          ? TransactionsEmpty()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
                color: Colors.white,
              ),
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return TransactionListItem(
                    _transactions[index],
                    _removeTransaction,
                  );
                },
                itemCount: _transactions.length,
              ),
            ),
    );
  }
}

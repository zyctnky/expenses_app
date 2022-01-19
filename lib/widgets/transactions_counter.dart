import 'package:flutter/material.dart';

class TransactionsCounter extends StatelessWidget {
  final int _filteredCount;
  final int _totalCount;

  const TransactionsCounter(this._filteredCount, this._totalCount);

  @override
  Widget build(BuildContext context) {
    return _totalCount > 0
        ? Container(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Showing: $_filteredCount in $_totalCount",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        : Container();
  }
}

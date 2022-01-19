import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/filter_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/transaction_new.dart';
import './widgets/transactions_counter.dart';

import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _userTransactions = [];
  DateTime _dateForFilter;
  String _categoryForFilter;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  List<Transaction> get _filteredTransactions {
    List<Transaction> transactions = _dateForFilter == null
        ? _userTransactions.toList()
        : _userTransactions.where((tx) => tx.date == _dateForFilter).toList();

    transactions = _categoryForFilter == null
        ? transactions.toList()
        : transactions
            .where((tx) => tx.categoryId == _categoryForFilter)
            .toList();

    return transactions;
  }

  void _addNewTransaction(
    String title,
    double amount,
    DateTime date,
    String categoryId,
  ) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
      categoryId: categoryId,
    );

    setState(() {
      _userTransactions.add(newTx);
    });

    _filterTransactionByDate(null, null, false);
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return TransactionNew(_addNewTransaction);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
  }

  void _filterTransactionByDate(
      DateTime date, String categoryId, bool closeDrawer) {
    setState(() {
      _dateForFilter = date;
      _categoryForFilter = categoryId;
    });
    if (closeDrawer) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
      ),
      drawer: FilterTransaction(_filterTransactionByDate),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions: _recentTransactions),
            TransactionList(
              _filteredTransactions,
              _deleteTransaction,
            ),
            TransactionsCounter(
              _filteredTransactions.length,
              _userTransactions.length,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

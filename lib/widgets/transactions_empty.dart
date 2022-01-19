import 'package:flutter/material.dart';

class TransactionsEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          child: Image.asset(
            'assets/images/no-data.png',
            fit: BoxFit.contain,
          ),
        ),
        Text(
          'No transaction added yet',
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}

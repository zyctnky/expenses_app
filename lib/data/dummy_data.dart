import 'package:flutter/material.dart';
import '../models/transaction_category.dart';

const DUMMY_CATEGORIES = const [
  TransactionCategory(
    id: "c1",
    title: "School Payments",
    color: Colors.blue,
    icon: Icons.school_outlined,
  ),
  TransactionCategory(
    id: "c2",
    title: "Game, Entertainment etc.",
    color: Colors.pink,
    icon: Icons.videogame_asset,
  ),
  TransactionCategory(
    id: "c3",
    title: "Book",
    color: Colors.brown,
    icon: Icons.book_outlined,
  ),
  TransactionCategory(
    id: "c4",
    title: "Electronics & Computer",
    color: Colors.teal,
    icon: Icons.computer_outlined,
  ),
  TransactionCategory(
    id: "c5",
    title: "Invoice",
    color: Colors.green,
    icon: Icons.list_alt,
  ),
];

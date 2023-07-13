import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Categories { food, travel, leisure, work }

const categoryIcons = {
  Categories.food: Icons.lunch_dining,
  Categories.travel: Icons.flight_takeoff,
  Categories.leisure: Icons.movie,
  Categories.work: Icons.work,
};

class Expense {
  //variable declaration
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  //constructor
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  //getter (to return formatted date)
  //third party package intl is used to format the date
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  //creating another constructor by giving it a different name(here its used to filter out the expenses of a particular category)
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Categories category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

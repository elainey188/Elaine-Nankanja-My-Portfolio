import 'dart:math';
import 'package:flutter/material.dart';
import 'transaction.dart';

class Vault {
  // Data members
  int id;
  String name;
  Image image;
  int daysRemaining;
  double goalAmount;
  double balanceAmount;
  bool isLocked;
  List <Transaction> transactions;
  LinearGradient gradient;

  // Constructors
  Vault()
      : id = DateTime.now().millisecondsSinceEpoch,
        name = '',
        image = Image.asset('assets/icons/icon_p.png'),
        daysRemaining = 0,
        goalAmount = 0.0,
        balanceAmount = 0.0,
        isLocked = true,
        transactions = [],
        gradient = LinearGradient(
          colors: [_generateRandomColor(), Color(0xFF111735)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

  Vault.parameterized({
    required this.name,
    required this.daysRemaining,
    required this.goalAmount,
  })  : id = DateTime.now().millisecondsSinceEpoch,
        image = Image.asset('assets/icons/icon_p.png'),
        balanceAmount = 0.0,
        isLocked = true,
        gradient = LinearGradient(
          colors: [_generateRandomColor(), Color(0xFF111735)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        transactions = [];


  // Method to generate a random color
  static Color _generateRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  // Setters
  void setName(String name) {
    this.name = name;
  }

  void setDaysRemaining(int daysRemaining) {
    if (daysRemaining < 1) {
      this.daysRemaining = 1;
    } else {
      this.daysRemaining = daysRemaining;
    }
  }

  void setGoalAmount(double goalAmount) {
    this.goalAmount = goalAmount;
  }

  void setBalanceAmount(double balanceAmount) {
    this.balanceAmount = balanceAmount;
  }

  void setIsLocked(bool isLocked) {
    this.isLocked = isLocked;
  }

  // Getters
  String getName() {
    return name;
  }

  int getId() {
    return id;
  }

  Image getImage() {
    return image;
  }

  int getDaysRemaining() {
    checkDaysRemaining();
    return daysRemaining;
  }

  double getGoalAmount() {
    return goalAmount;
  }

  double getBalanceAmount() {
    return balanceAmount;
  }

  bool getIsLocked() {
    checkIfLocked();
    return isLocked;
  }

  List<Transaction> getTransactions(){
    return transactions;
  }

  void addTransaction(Transaction transaction){
    transactions.add(transaction);
  }
  // Helper method
  // Check if the vault is locked
  void checkIfLocked() {
    // Unlock vault if the goal is reached or the days remaining is 0
    if ((balanceAmount <= goalAmount) || (daysRemaining != 0)) {
      isLocked = true;
    } else {
      isLocked = false;
    }
  }

  // Check how many days are remaining
  void checkDaysRemaining() {
    // Calculate the days remaining
    DateTime now = DateTime.now();
    DateTime goalDate = DateTime(now.year, now.month, now.day + daysRemaining);
    Duration difference = goalDate.difference(now);
    daysRemaining = difference.inDays;
  }

  // Increment balance
  void incrementBalance(double amount) {
    balanceAmount += double.parse(amount.toStringAsFixed(2));
  }

  // Decrease balance
  void decreaseBalance(double amount) {
    balanceAmount -= double.parse(amount.toStringAsFixed(2));
  }
}
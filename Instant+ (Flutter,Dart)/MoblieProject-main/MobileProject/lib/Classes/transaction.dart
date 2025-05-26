import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  // Data members
  int vaultId;
  String vaultName;
  int paymentMethodId;
  String paymentMethodCardNumber;

  double amount;
  String transactionType; // 'Deposit' or 'Withdrawal'
  String transactionDate;
  String transactionTime;

  // Constructor
  Transaction()
      : vaultId = 0,
        vaultName = '',
        paymentMethodId = 0,
        paymentMethodCardNumber = '',
        amount = 0.0,
        transactionType = '',
        transactionDate = DateFormat('MMMM d, yyyy').format(DateTime.now()),
        transactionTime = DateFormat('h:mma').format(DateTime.now()).toLowerCase();

  Transaction.parameterized({
    required this.vaultId,
    required this.vaultName,
    required this.paymentMethodId,
    required this.paymentMethodCardNumber,
    required this.amount,
    required this.transactionType,
  })  : transactionDate = DateFormat('MMMM d, yyyy').format(DateTime.now()),
        transactionTime = DateFormat('h:mma').format(DateTime.now()).toLowerCase();


  // Setters
  void setAmount(double amount){
    this.amount = amount;
  }

  // Getters
  String getVaultName() {
    return vaultName;
  }

  int getVaultId() {
    return vaultId;
  }

  int getPaymentMethodId() {
    return paymentMethodId;
  }

  String getPaymentMethodCardNumber() {
    return paymentMethodCardNumber;
  }

  double getAmount() {
    return amount;
  }

  String getTransactionType() {
    return transactionType;
  }

  String getTransactionDate() {
    return transactionDate;
  }

  String getTransactionTime() {
    return transactionTime;
  }
}
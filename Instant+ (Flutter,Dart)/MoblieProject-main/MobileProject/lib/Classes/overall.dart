import 'package:flutter/foundation.dart';
import 'user_info.dart';
import 'vault.dart';
import 'transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'notifications.dart';

class Overall extends ChangeNotifier {
  // Data members
  UserInfo userInfo;
  List<Vault> listVaults;
  List<Transaction> transactions;
  List<Notification> notifications;

  String currentMonthYear;
  String currentDayMonthYear;
  double currentBalance;
  double currentProfit;
  double convertedAmount;

  // Constructor
  Overall()
      : userInfo = UserInfo(),
        listVaults = [],
        transactions = [],
        notifications = [],
        currentMonthYear = '',
        currentDayMonthYear = '',
        currentBalance = 0.0,
        currentProfit = 0.0,
        convertedAmount = 0.0 {
    _setCurrentMonthYear();
    _setCurrentDayMonthYear();
  }

  Overall.parameterized({
    required this.userInfo,
    required this.listVaults,
    required this.transactions,
    required this.notifications,
    required this.currentBalance,
    required this.currentProfit,
    required this.convertedAmount,
  })  : currentMonthYear = '',
        currentDayMonthYear = '' {
    _setCurrentMonthYear();
    _setCurrentDayMonthYear();
  }

  // Setters
  void setUserInfo(UserInfo userInfo) {
    this.userInfo = userInfo;
    notifyListeners();
  }

  void setListVaults(List<Vault> listVaults) {
    this.listVaults = listVaults;
    notifyListeners();
  }

  void setTransactions(List<Transaction> transactions) {
    this.transactions = transactions;
    notifyListeners();
  }

  void setNotifications(List<Notification> notifications) {
    this.notifications = notifications;
    notifyListeners();
  }

  void _setCurrentMonthYear() {
    DateTime now = DateTime.now();
    String month = _getMonthName(now.month);
    int year = now.year;
    currentMonthYear = '$month $year';
    notifyListeners();
  }

  void _setCurrentDayMonthYear() {
    DateTime now = DateTime.now();
    String day = now.day.toString();
    String month = _getFullMonthName(now.month);
    int year = now.year;
    currentDayMonthYear = '$day $month, $year';
    notifyListeners();
  }

  void setCurrentBalance(double balance) {
    currentBalance = balance;
    notifyListeners();
  }

  void setCurrentProfit(double profit) {
    currentProfit = profit;
    notifyListeners();
  }

  void setConvertedAmount(double amount) {
    convertedAmount = amount;
    notifyListeners();
  }

  // Getters
  UserInfo getUserInfo() {
    return userInfo;
  }

  List<Vault> getListVaults() {
    return listVaults;
  }

  List<Transaction> getTransactions() {
    return transactions;
  }

  List<Notification> getNotifications() {
    return notifications;
  }

  double getCurrentBalance() {
    calculateCurrentBalance();
    return currentBalance;
  }

  double getCurrentProfit() {
    calculateCurrentProfit();
    return currentProfit;
  }

  String getCurrentMonthYear() {
    return currentMonthYear;
  }

  String getCurrentDayMonthYear() {
    return currentDayMonthYear;
  }

  double getConvertedAmount() {
    return convertedAmount;
  }

  // Helper methods
  String _getMonthName(int month) {
    const List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[month - 1];
  }

  String _getFullMonthName(int month) {
    const List<String> monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  // Calculate the current balance
  void calculateCurrentBalance() {
    double balance = 0.0;
    for (Vault vault in listVaults) {
      balance += vault.getBalanceAmount();
    }
    setCurrentBalance(balance);
  }

  // Calculate the current profit
  void calculateCurrentProfit() {
    double profit = 0.0;
    for (Transaction transaction in transactions) {
      if (transaction.getTransactionType() == 'Deposit') {
        profit += transaction.getAmount();
      } else if (transaction.getTransactionType() == 'Withdrawal') {
        profit -= transaction.getAmount();
      }
    }
    setCurrentProfit(profit);
  }

  // Add a vault
  void addVault(Vault vault) {
    listVaults.add(vault);
    notifyListeners();
  }

  // Remove a vault
  void removeVault(Vault vault) {
    listVaults.remove(vault);
    notifyListeners();
  }

  // Add a transaction
  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    notifyListeners();
  }

  // Update the user info
  void updateUserInfo(UserInfo updatedUserInfo) {
    userInfo = updatedUserInfo;
    notifyListeners();
  }

  // Get only transactions of type 'Deposit'
  List<Transaction> getDepositTransactions() {
    List<Transaction> depositTransactions = [];

    // Extract all deposit transactions
    for (Transaction transaction in transactions) {
      if (transaction.getTransactionType() == 'Deposit') {
        depositTransactions.add(transaction);
      }
    }

    // Return the last 10 transactions
    if (depositTransactions.length > 10) {
      return depositTransactions.sublist(depositTransactions.length - 10);
    }

    // Latest transactions first
    return depositTransactions.reversed.toList();
  }

  // Get only transactions of type 'Withdrawal'
  List<Transaction> getWithdrawalTransactions() {
    List<Transaction> withdrawalTransactions = [];

    // Extract all withdrawal transactions
    for (Transaction transaction in transactions) {
      if (transaction.getTransactionType() == 'Withdrawal') {
        withdrawalTransactions.add(transaction);
      }
    }

    // Return the last 10 transactions
    if (withdrawalTransactions.length > 10) {
      return withdrawalTransactions.sublist(withdrawalTransactions.length - 10);
    }

    // Latest transactions first
    return withdrawalTransactions.reversed.toList();
  }

  // Get recent transactions chart data
  List<FlSpot> getMonthlyTransactionData() {
    // Initialize a map to store the total transactions for each month
    Map<int, double> monthlyTotals = {
      0: 0.0, // SEP
      1: 0.0, // OCT
      2: 0.0, // NOV
      3: 0.0, // DEC
      4: 0.0, // JAN
      5: 0.0, // FEB
      6: 0.0, // MAR
      7: 0.0, // APR
      8: 0.0, // MAY
      9: 0.0, // JUN
    };

    // Iterate through the transactions and calculate the totals for each month
    for (Transaction transaction in transactions) {
      String dateString = transaction.getTransactionDate();
      DateTime date = DateFormat('MMMM d, yyyy').parse(dateString);
      int month = date.month;

      // Map the month to the corresponding index (0 for SEP, 1 for OCT, etc.)
      int monthIndex = (month - 9) % 12;
      if (monthIndex < 0) {
        monthIndex += 12;
      }

      if (transaction.getTransactionType() == 'Deposit') {
        monthlyTotals[monthIndex] = monthlyTotals[monthIndex]! + transaction.getAmount();
      } else if (transaction.getTransactionType() == 'Withdrawal') {
        monthlyTotals[monthIndex] = monthlyTotals[monthIndex]! - transaction.getAmount();
      }
    }

    // Convert the map to a list of FlSpot
    List<FlSpot> spots = [];
    monthlyTotals.forEach((monthIndex, total) {
      spots.add(FlSpot(monthIndex.toDouble(), total));
    });

    return spots;
  }

  // Get up to last 10 recent notifications
  List<Notification> getRecentNotifications() {
    if (notifications.length > 10) {
      return notifications.sublist(notifications.length - 10);
    }
    return notifications.reversed.toList();
  }

  // Add a notification
  void addNotification(Notification notification) {
    notifications.add(notification);
    notifyListeners();
  }
}
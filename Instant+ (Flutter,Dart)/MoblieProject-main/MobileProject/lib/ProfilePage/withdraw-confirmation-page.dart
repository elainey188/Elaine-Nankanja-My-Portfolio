import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../Classes/overall.dart';
import '../Classes/transaction.dart';
import '../Classes/vault.dart';
import '../Classes/payment_method.dart';
import 'withdraw.dart';
import '../Classes/notifications.dart' as custom;

class WithdrawConfirmationPage extends StatefulWidget {
  final TextEditingController amountController;
  final PaymentMethod? selectedPaymentMethod;
  final Vault? selectedVault;
  final List<Map<String, dynamic>> recentTransactions;

  WithdrawConfirmationPage({
    required this.amountController,
    required this.selectedPaymentMethod,
    required this.selectedVault,
    required this.recentTransactions,
  });

  @override
  _WithdrawConfirmationPageState createState() => _WithdrawConfirmationPageState();
}

class _WithdrawConfirmationPageState extends State<WithdrawConfirmationPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _performWithdrawal();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _performWithdrawal() {
    Future.delayed(Duration(seconds: 5), () {
      final overall = Provider.of<Overall>(context, listen: false);
      final double amount = double.parse(widget.amountController.text);

      if (widget.selectedVault != null) {
        widget.selectedVault!.decreaseBalance(amount);
        // NEW - Add transactiont to vault
        widget.selectedVault!.addTransaction(Transaction.parameterized(
          vaultId: widget.selectedVault!.id, 
          vaultName: widget.selectedVault!.name, 
          paymentMethodId: widget.selectedPaymentMethod!.id, 
          paymentMethodCardNumber: widget.selectedPaymentMethod!.cardNumber, 
          amount: amount, 
          transactionType: 'Withdrawal'
        )); 
        
        overall.setListVaults(overall.getListVaults()); // Notify listeners

        // Add transaction
        overall.addTransaction(Transaction.parameterized(
          vaultId: widget.selectedVault!.id,
          vaultName: widget.selectedVault!.name,
          paymentMethodId: widget.selectedPaymentMethod!.id,
          paymentMethodCardNumber: widget.selectedPaymentMethod!.cardNumber,
          amount: amount,
          transactionType: 'Withdrawal',
        ));
      }

      // Add notification
      overall.addNotification(custom.Notification.parameterized(
        description: 'Withdrawal Successful',
      ));

      // TODO: REMOVE
      setState(() {
        widget.recentTransactions.add({
          'vault': widget.selectedVault!.getName(),
          'paymentMethod': '************ ${widget.selectedPaymentMethod!.getCardNumber().substring(widget.selectedPaymentMethod!.getCardNumber().length - 4)}',
          'amount': amount,
        });
        if (widget.recentTransactions.length > 10) {
          widget.recentTransactions.removeAt(0);
        }
        _isAnimationCompleted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isAnimationCompleted) {
          Navigator.of(context).pop(widget.recentTransactions);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xff850df4),
        body: Center(
          child: Lottie.asset(
            "assets/Images/check.json",
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward();
            },
          ),
        ),
      ),
    );
  }
}
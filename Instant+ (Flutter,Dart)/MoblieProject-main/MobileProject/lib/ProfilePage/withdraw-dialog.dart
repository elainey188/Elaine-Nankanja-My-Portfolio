import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'withdraw-confirmation-page.dart';
import '../Classes/payment_method.dart';
import '../Classes/vault.dart';
import '../Classes/overall.dart';
import '../Classes/notifications.dart' as custom;
import 'package:provider/provider.dart';

class WithdrawDialog extends StatefulWidget {
  final TextEditingController amountController;
  final PaymentMethod? selectedPaymentMethod;
  final Vault? selectedVault;
  final List<Map<String, dynamic>> recentTransactions;

  WithdrawDialog({
    required this.amountController,
    required this.selectedPaymentMethod,
    required this.selectedVault,
    required this.recentTransactions,
  });

  @override
  _WithdrawDialogState createState() => _WithdrawDialogState();
}

class _WithdrawDialogState extends State<WithdrawDialog> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4457B1), Color(0xFFA91CB3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFBA93DC),
              blurRadius: 10.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Confirm Withdrawal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Do you wish to continue with the withdrawal?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4457B1), Color(0xFFA91CB3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFBA93DC),
                      blurRadius: 10.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: SwipeableButtonView(
                  buttonText: "SLIDE TO CONFIRM",
                  buttonWidget: Container(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xff0003fd),
                    ),
                  ),
                  activeColor: Color(0xff850df4),
                  onWaitingProcess: () {
                    Future.delayed(const Duration(seconds: 3),
                            () => setState(() => isFinished = true));
                  },
                  isFinished: isFinished,
                  onFinish: () async {
                    Navigator.of(context).pop(); // Close the dialog before navigating
                    await Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: WithdrawConfirmationPage(
                              amountController: widget.amountController,
                              selectedPaymentMethod: widget.selectedPaymentMethod,
                              selectedVault: widget.selectedVault,
                              recentTransactions: widget.recentTransactions,
                            )));
                    setState(() => isFinished = false);
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
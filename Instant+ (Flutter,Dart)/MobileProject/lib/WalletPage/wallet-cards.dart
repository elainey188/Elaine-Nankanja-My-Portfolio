import 'package:flutter/material.dart';
import 'wallet-main.dart'; // Import the constants from wallet-main.dart
import '../Classes/vault.dart'; // Ensure this import is present
import '../Classes/overall.dart'; // Ensure this import is present
import 'package:provider/provider.dart'; // Ensure this import is present
import '../Classes/notifications.dart' as custom;

class VaultCardData {
  VaultCardData({
    required this.gradient,
    required this.name,
    required this.daysRemaining,
    required this.image,
    required this.goalAmount,
    required this.balanceAmount,
    required this.id,
    required this.isLocked,
  });

  final Gradient gradient;
  final String name;
  final int daysRemaining;
  final Image image;
  final double goalAmount;
  final double balanceAmount;
  final int id;
  final bool isLocked;
}

class VaultCard extends StatefulWidget {
  const VaultCard({
    super.key,
    required this.gradient,
    required this.name,
    required this.daysRemaining,
    required this.image,
    required this.goalAmount,
    required this.balanceAmount,
    required this.id,
    required this.isLocked,
  });

  final Gradient gradient;
  final String name;
  final int daysRemaining;
  final Image image;
  final double goalAmount;
  final double balanceAmount;
  final int id;
  final bool isLocked;

  @override
  _VaultCardState createState() => _VaultCardState();
}

class _VaultCardState extends State<VaultCard> {
  final _formKey = GlobalKey<FormState>();
  late String _editVaultName;
  late int _editVaultDaysRemaining;
  late double _editVaultGoalAmount;

  @override
  void initState() {
    super.initState();
    _editVaultName = widget.name;
    _editVaultDaysRemaining = widget.daysRemaining;
    _editVaultGoalAmount = widget.goalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: kCardWidth,
        height: kCardHeight,
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Edit Button
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Color(0xFF3852C7)],
                            ),
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF090909),
                                blurRadius: 8.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          width: 360,
                          height: 595,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                children: [
                                  SizedBox(height: 16),
                                  // Input Vault Name
                                  TextFormField(
                                    initialValue: _editVaultName,
                                    decoration: InputDecoration(
                                      labelText: 'Vault Name',
                                      labelStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      prefixIcon: Icon(Icons.account_balance_wallet, color: Colors.white),
                                      counterStyle: TextStyle(color: Colors.white),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                    onSaved: (value) {
                                      _editVaultName = value!;
                                    },
                                  ),
                                  SizedBox(height: 16),

                                  // Input Days Remaining
                                  TextFormField(
                                    initialValue: _editVaultDaysRemaining.toString(),
                                    decoration: InputDecoration(
                                      labelText: 'Days Remaining',
                                      labelStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      prefixIcon: Icon(Icons.calendar_today, color: Colors.white),
                                      counterStyle: TextStyle(color: Colors.white),
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    onSaved: (value) {
                                      _editVaultDaysRemaining = int.parse(value!);
                                    },
                                  ),
                                  SizedBox(height: 16),

                                  // Input Goal Amount
                                  TextFormField(
                                    initialValue: _editVaultGoalAmount.toString(),
                                    decoration: InputDecoration(
                                      labelText: 'Goal Amount',
                                      labelStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      prefixIcon: Icon(Icons.attach_money, color: Colors.white),
                                      counterStyle: TextStyle(color: Colors.white),
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    onSaved: (value) {
                                      _editVaultGoalAmount = double.parse(value!);
                                    },
                                  ),
                                  SizedBox(height: 16),

                                  // Edit Vault Button
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        setState(() {
                                          // Update the properties directly
                                          _editVaultName = _editVaultName;
                                          _editVaultDaysRemaining = _editVaultDaysRemaining;
                                          _editVaultGoalAmount = _editVaultGoalAmount;

                                          // Find the selected vault in the list and update its properties
                                          final selectedVault = Provider.of<Overall>(context, listen: false).listVaults.firstWhere((vault) => vault.id == widget.id);
                                          selectedVault.setName(_editVaultName);
                                          selectedVault.setDaysRemaining(_editVaultDaysRemaining);
                                          selectedVault.setGoalAmount(_editVaultGoalAmount);
                                        });

                                        // Update the Overall provider
                                        Provider.of<Overall>(context, listen: false).notifyListeners();

                                        Navigator.pop(context);
                                        // Create a new Notification object
                                        final newNotification = custom.Notification.parameterized(
                                          description: 'Vault edited successfully',
                                        );

                                        // Add the new Notification to the Overall notifications list
                                        Provider.of<Overall>(context, listen: false).addNotification(newNotification);

                                        // Show the SnackBar
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Vault edited successfully')),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Color(0xFFC80BB9), Color(0xFF3852C7)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        constraints: BoxConstraints(minHeight: 50),
                                        child: Text(
                                          'Edit Vault',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),

            // Vault Name
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            // Remaining Days
            Positioned(
              top: 40,
              left: 16,
              child: Text(
                '${widget.daysRemaining} Days Remaining',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            // Vault Image
            Positioned(
              bottom: 16,
              left: 16,
              child: Container(
                width: 81,
                height: 81,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: widget.image,
                ),
              ),
            ),
            // Goal Column
            Positioned(
              bottom: 16,
              left: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Goal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    '\$${widget.goalAmount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            // Balance Column
            Positioned(
              bottom: 16,
              left: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    '\$${widget.balanceAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),

            // Lock/Unlock Icon
            if (widget.isLocked)
              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.isLocked ? Icons.lock : Icons.lock_open,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
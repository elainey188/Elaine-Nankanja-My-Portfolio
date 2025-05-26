import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes/overall.dart';
import '../Classes/vault.dart';
import '../Classes/notifications.dart' as custom;

class AddVaultPage extends StatefulWidget {
  @override
  _AddVaultPageState createState() => _AddVaultPageState();
}

class _AddVaultPageState extends State<AddVaultPage> {
  final _formKey = GlobalKey<FormState>();
  String _newVaultname = '';
  int _newVaultDaysRemaining = 0;
  double _newVaultGoalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backgrounds/emback.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            // Title
            Positioned(
              top: 0,
              right: 26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Add Vault',
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'Instant+',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Center(
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
                      color: Color(0xFF020629),
                      blurRadius: 5.0,
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
                            _newVaultname = value!;
                          },
                        ),
                        SizedBox(height: 16),

                        // Input Days Remaining
                        TextFormField(
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
                            _newVaultDaysRemaining = int.parse(value!);
                          },
                        ),
                        SizedBox(height: 16),

                        // Input Goal Amount
                        TextFormField(
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
                            _newVaultGoalAmount = double.parse(value!);
                          },
                        ),
                        SizedBox(height: 16),

                        // Add Vault Button
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final newVault = Vault.parameterized(
                                name: _newVaultname,
                                daysRemaining: _newVaultDaysRemaining,
                                goalAmount: _newVaultGoalAmount,
                              );
                              Provider.of<Overall>(context, listen: false).setListVaults(
                                [...Provider.of<Overall>(context, listen: false).getListVaults(), newVault],
                              );
                              Navigator.pop(context);


                              // Create a new Notification object
                              final newNotification = custom.Notification.parameterized(
                                description: 'Vault added successfully',
                              );

                              // Add the new Notification to the Overall notifications list
                              Provider.of<Overall>(context, listen: false).addNotification(newNotification);

                              // Show the SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Vault added successfully')),
                              );
                            }
                          },
                          child: Text('Add Vault'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
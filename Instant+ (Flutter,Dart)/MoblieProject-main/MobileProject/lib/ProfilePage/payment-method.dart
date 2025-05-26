import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Classes/user_info.dart';
import '../Classes/payment_method.dart';
import '../Classes/overall.dart';
import '../Classes/notifications.dart' as custom;

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  void _showProfileCard(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 600, // Adjust the width as needed
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF121E7E), Color(0xFF3B1250)],
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF090909),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    'Enter Payment Details',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Divider(color: Colors.white),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name on Card',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.account_circle, color: Colors.white),
                      counterStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name on the card';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.credit_card, color: Colors.white),
                      counterStyle: TextStyle(color: Colors.white),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.length != 16) {
                        return 'Please enter a valid 16-digit card number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          controller: _expirationDateController,
                          decoration: InputDecoration(
                            labelText: 'Expiration Date (MMYY)',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            prefixIcon: Icon(Icons.calendar_today, color: Colors.white),
                            counterStyle: TextStyle(color: Colors.white),
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.length != 4) {
                              return 'Please enter a valid 4-digit expiration date';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          controller: _cvvController,
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            counterStyle: TextStyle(color: Colors.white),
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.length != 3) {
                              return 'Please enter a valid 3-digit CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final overall = Provider.of<Overall>(context, listen: false);
                        final userInfo = overall.userInfo;

                        final paymentMethod = PaymentMethod.parameterized(
                          nameOnCard: _nameController.text,
                          cardNumber: _cardNumberController.text,
                          expiration: _expirationDateController.text,
                          cvv: _cvvController.text,
                        );

                        setState(() {
                          userInfo.addPaymentMethod(paymentMethod);
                        });



                        // Create a new Notification object
                        final newNotification = custom.Notification.parameterized(
                          description: 'Card information saved. You now have ${userInfo.getNumberOfPaymentMethods()} cards linked.',
                        );

// Add the new Notification to the Overall notifications list
                        Provider.of<Overall>(context, listen: false).addNotification(newNotification);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(
                              'Card information saved. You now have ${userInfo.getNumberOfPaymentMethods()} cards linked.')),
                        );

                        // Clear the text fields
                        _nameController.clear();
                        _cardNumberController.clear();
                        _expirationDateController.clear();
                        _cvvController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Add Card'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }  @override
  Widget build(BuildContext context) {
    final overall = Provider.of<Overall>(context);
    final userInfo = overall.userInfo;

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
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.white, // Set the back button color to white
          ),
        ),
        body: Stack(
          children: [
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
                      color: Colors.black,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                width: 360,
                height: 595,
                child: ListView(
                  children: [
                    IconButton(
                      icon: DefaultTextStyle(
                        style: TextStyle(color: Colors.white),
                        child: Row(
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(width: 4),
                            Text('Add Account'),
                          ],
                        ),
                      ),
                      onPressed: () {
                        _showProfileCard(context);
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Linked Accounts',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    ...userInfo.paymentMethods.map((method) {
                      return ListTile(
                        title: Text(
                          method.nameOnCard,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '**** **** **** ${method.cardNumber.substring(method.cardNumber.length - 4)}',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              userInfo.paymentMethods.remove(method);
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            // Title
            Positioned(
              top: 0,
              right: 26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Payment Method',
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
                        color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
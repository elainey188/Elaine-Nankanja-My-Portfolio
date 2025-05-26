import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExchangeRate extends StatefulWidget {
  const ExchangeRate({Key? key}) : super(key: key);

  @override
  _ExchangeRateState createState() => _ExchangeRateState();
}

class _ExchangeRateState extends State<ExchangeRate> {
  Map<String, dynamic>? _exchangeRates;
  bool _isLoading = true;
  final List<String> _currencies = [
    "USD", "EUR", "GBP", "JPY", "CAD", "AUD", "CHF", "CNY", "INR", "BRL",
    "ZAR", "RUB", "KRW", "SGD", "MYR"
  ];
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _amount = 1.0;
  double _convertedAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
  }

  Future<void> _fetchExchangeRates() async {
    try {
      var response = await http.get(Uri.parse(
          'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/eur.json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rates = data['eur'];
        final filteredRates = Map<String, dynamic>.fromEntries(
            rates.entries.where((entry) => _currencies.contains(entry.key.toUpperCase()))
        );
        setState(() {
          _exchangeRates = filteredRates;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      setState(() {
        _exchangeRates = null;
        _isLoading = false;
      });
    }
  }

  void _convertCurrency() {
    if (_exchangeRates != null) {
      double fromRate = _exchangeRates![_fromCurrency.toLowerCase()] ?? 1.0;
      double toRate = _exchangeRates![_toCurrency.toLowerCase()] ?? 1.0;
      setState(() {
        _convertedAmount = (_amount / fromRate) * toRate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Color(0xFF3852C7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF010739),
                      blurRadius: 20.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          Text(
                            'Exchange Rates',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: ListView(
                              children: _currencies.map((currency) {
                                return Text(
                                  '$currency: ${_exchangeRates?[currency.toLowerCase()]?.toStringAsFixed(2) ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Currency Converter',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'From Currency',
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  value: _fromCurrency,
                                  dropdownColor: Color(0xFF030740),
                                  items: _currencies.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _fromCurrency = newValue!;
                                    });
                                  },
                                  validator: (value) => value == null ? 'Please select a currency' : null,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'To Currency',
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  value: _toCurrency,
                                  dropdownColor: Color(0xFF030740),
                                  items: _currencies.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              value,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _toCurrency = newValue!;
                                    });
                                  },
                                  validator: (value) => value == null ? 'Please select a currency' : null,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            onChanged: (String value) {
                              setState(() {
                                _amount = double.tryParse(value) ?? 1.0;
                                _convertCurrency(); // Automatically update converted amount
                              });
                            },
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              _convertCurrency();
                            },
                            child: Text('Convert'),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Converted Amount: ${_convertedAmount.toStringAsFixed(2)} $_toCurrency',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.attach_money, color: Colors.yellow),
            SizedBox(width: 8),
            Text(
              'Exchange Rate',
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Poppins",
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
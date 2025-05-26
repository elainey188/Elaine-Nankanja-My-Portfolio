import 'package:flutter/material.dart';
import 'package:mobileproject/HomePage/ExchangeRateState.dart';
import 'recent-transaction.dart';
import 'recent-chart.dart';
import '../Classes/overall.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

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
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [

            // Chart + Transactions
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: RecentChart(),
                  ),
                  Positioned.fill(
                    child: RecentTransactions(),
                  ),
                ],
              ),
            ),

            // Title
            Positioned(
              top: 0,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'Instant+',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),

            // Exchange Rate API Button
            Positioned(
              top: 12,
              left: 16,
              child: ExchangeRate(),
            ),
          ],
        ),
      ),
    );
  }
}
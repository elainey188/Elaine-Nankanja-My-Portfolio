import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../Classes/overall.dart';
import 'package:neon/neon.dart';

class RecentChart extends StatelessWidget {
  const RecentChart({super.key});

  @override
  Widget build(BuildContext context) {
    final overall = Provider.of<Overall>(context);

    String currentMonthYear = overall.getCurrentMonthYear();
    String overallBalance = '\$${overall.getCurrentBalance().toStringAsFixed(2)}';
    String profitOrLoss = '\$${overall.getCurrentProfit().toStringAsFixed(2)}';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentMonthYear,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              overallBalance,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              profitOrLoss,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  backgroundColor: Colors.transparent,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          );
                          switch (value.toInt()) {
                            case 0:
                              return Text('SEP', style: style);
                            case 1:
                              return Text('OCT', style: style);
                            case 2:
                              return Text('NOV', style: style);
                            case 3:
                              return Text('DEC', style: style);
                            case 4:
                              return Text('JAN', style: style);
                            case 5:
                              return Text('FEB', style: style);
                            case 6:
                              return Text('MAR', style: style);
                            case 7:
                              return Text('APR', style: style);
                            case 8:
                              return Text('MAY', style: style);
                            case 9:
                              return Text('JUN', style: style);
                          }
                          return const Text('');
                        },
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (touchedSpot) => Colors.blue,
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      tooltipRoundedRadius: 50,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((e) {
                          return LineTooltipItem(
                            e.y.toString(),
                            const TextStyle(),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: overall.getMonthlyTransactionData(),
                      isCurved: true,
                      color: Neon(
                        text: '',
                        color: Colors.pink,
                        font: NeonFont.Membra,
                        flickeringText: false,
                        glowingDuration: Duration(seconds: 1),
                      ).color,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
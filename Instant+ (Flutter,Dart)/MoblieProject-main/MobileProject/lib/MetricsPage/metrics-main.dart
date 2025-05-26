import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'charts.dart';
// import '../Classes/currencyConversion.dart';
import '../Classes/vault.dart';
import '../Classes/overall.dart';

/*
    Description:
    - MetricsMain is the main page for the metrics page
    - Shows user earnings with graph
    - Shows vaults accounts with graph
 */

/*
    TODO:
    - Integrate Transactions with Vaults so we can display charts based of users->vaults->transactions and more
    - Make charts from class data rather than temp data (class integration)
    ...
 */

class MetricsMain extends StatefulWidget {
  MetricsMain({super.key});

  @override
  MetricsMainState createState() => MetricsMainState();
}

class MetricsMainState extends State<MetricsMain>{
  String currentCurrency = "CAD";
  String? selectedCurrency;
  // CurrencyConversion currencyConverter = CurrencyConversion();
  late Overall overall;
  late List<Vault> vaults, vaults2;
  int currentVaultIndex = 0;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    overall = Provider.of<Overall>(context);
  }

  Vault get currentVault => overall.getListVaults()[currentVaultIndex];

  void _handleSwipeLeft() {
    print("swipe left");
    setState(() {
      if (currentVaultIndex <overall.getListVaults().length - 1) {
        currentVaultIndex++;
      }else if(currentVaultIndex == overall.getListVaults().length-1){
        currentVaultIndex = 0;
      }
    });
  }

  void _handleSwipeRight() {
    print("swipe right");
    setState(() {
      if (currentVaultIndex > 0) {
        currentVaultIndex--;
      }else if(currentVaultIndex == 0){
        currentVaultIndex = overall.getListVaults().length-1;
      }
    });
  }

  //Change the way we generate this list of currencies, we can grab every currency available from the api 
  final List<String> currencies = [ "USD", "EUR", "GBP", "JPY", "CAD", "AUD", "CHF", "CNY", "INR", "BRL", 
    "ZAR", "RUB", "KRW", "SGD", "MYR"
  ]; 

  void currencyDialog() async{
    selectedCurrency = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Currency'),
          content: SizedBox(
            height: 300,
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: ListBody(
                children:currencies.map((currency){
                  return ListTile(
                    title: Text(currency),
                    onTap:(){
                      Navigator.pop(context, currency);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );

    // Removed because someone deleted currentCurrency class
    // if(selectedCurrency != null){
    //   if(selectedCurrency == "CAD"){
    //     currencyConverter.reset(overall);
    //   }else if (selectedCurrency != overall.getCurrency()){
    //     print(selectedCurrency);
    //     print(overall.getCurrency());
    //     await currencyConverter.convert(overall, overall.getCurrency(), selectedCurrency!);
    //   }
    //   setState((){});
    // }
    // for(var transaction in overall.getTransactions()){
    //   print(transaction.getOriginalAmount());
    //   print(transaction.getAmount());
    // }
    // for (var vault in overall.getListVaults()){
    //   print(vault.getOriginalAmount());
    //   print(vault.getBalanceAmount());
    //   for (var transaction in vault.getTransactions()){
    //     print(transaction.getAmount());
    //     print(transaction.getAmount());
    //   }
    // }

    // await currencyConverter.convert(overall, currentCurrency, selectedCurrency!);
    // currentCurrency = selectedCurrency!;
    // setState((){});
  }

  @override
  Widget build(BuildContext context) {
    if(overall.getListVaults().isEmpty){
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/emback.png'),
            fit: BoxFit.cover,
          ),
        ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //center align the text box and constrain how far it spans out
            Container(
              constraints: BoxConstraints(maxWidth: 200),
              alignment: Alignment.center,
              child: Text(
                'Revisit this page after creating vaults and transactions for some metrics :)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize:20)
              ),
            ),
            SizedBox(height:30),
            CircularProgressIndicator()
          ],
        ),
      )
      );
    }
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
            Container(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 100),
                  // Floating widget card for Line Chart
                  buildFloatingCard(
                    title: "Savings over Time",
                    child: buildAreaChart(overall.getTransactions()),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onHorizontalDragEnd: (details){
                      if (details.primaryVelocity! < 0){
                        _handleSwipeLeft();
                      }else if (details.primaryVelocity! > 0){
                        _handleSwipeRight();
                      }
                    },
                    child: buildFloatingCard(
                      title: "${currentVault.name}",
                      child: buildLineChart(currentVault)
                    )
                    
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
                    'Metrics',
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
          ],
        ),
      ),
    );
  }
}

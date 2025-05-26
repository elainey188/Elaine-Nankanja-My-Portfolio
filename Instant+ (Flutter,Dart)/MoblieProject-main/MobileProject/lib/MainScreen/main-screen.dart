import 'package:flutter/material.dart';
import '../HomePage/home-main.dart';
import '../WalletPage/wallet-main.dart';
import '../MetricsPage/metrics-main.dart';
import '../ProfilePage/profile-main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const LinearGradient _bottomNavBarGradient = LinearGradient(
    colors: [Color(0xFF040929), Color(0xDD030E55), Color(0xFF01051E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient _avatarNavBarGradient = LinearGradient(
    colors: [Color(0xFF4457B1), Color(0xFFA91CB3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static List<Widget> _widgetOptions = <Widget>[
    HomeMain(),
    WalletMain(),
    MetricsMain(),
    ProfileMain(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.4),
        child: ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              gradient: _bottomNavBarGradient,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFE1E2EA),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: SizedBox(
              height: 80,
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: _avatarNavBarGradient,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF9BA6F3),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.home, color: Colors.white),
                      ),
                    ),
                    label: '●',
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: _avatarNavBarGradient,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF9BA6F3),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.account_balance_wallet, color: Colors.white),
                      ),
                    ),
                    label: '●',
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: _avatarNavBarGradient,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF9BA6F3),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.show_chart, color: Colors.white),
                      ),
                    ),
                    label: '●',
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: _avatarNavBarGradient,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF9BA6F3),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.settings, color: Colors.white),
                      ),
                    ),
                    label: '●',
                    backgroundColor: Colors.transparent,
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                backgroundColor: Colors.transparent,
                selectedLabelStyle: TextStyle(fontSize: 10),
                unselectedLabelStyle: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
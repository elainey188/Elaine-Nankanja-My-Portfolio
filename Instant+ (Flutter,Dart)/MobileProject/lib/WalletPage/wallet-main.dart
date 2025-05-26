import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes/overall.dart';
import '../Classes/vault.dart';
import 'wallet-cards.dart';
import 'add-vault.dart';

/*
    Description:
    - WalletMain is the main page for the wallet vault
    - Shows list of vaults
    - Allows to create new vault
    - Allows to delete vault
    - Allows to edit vault
 */

/*
    TODO:
    - UI Layout
    - SnackBar Navigation (Wallet, Metrics, Profile)
    ...
 */

const double kCardHeight = 225;
const double kCardWidth = 356;

const double kSpaceBetweenCard = 24;
const double kSpaceBetweenUnselectCard = 32;
const double kSpaceUnselectedCardToTop = 290;

const Duration kAnimationDuration = Duration(milliseconds: 245);

class WalletMain extends StatefulWidget {
  const WalletMain({super.key});

  @override
  _WalletMainState createState() => _WalletMainState();
}

class _WalletMainState extends State<WalletMain> {
  int? selectedCardIndex = 0;
  late List<VaultCard> vaultCards; // Define vaultCards as a class member

  @override
  Widget build(BuildContext context) {
    final overall = Provider.of<Overall>(context);

    final List<VaultCardData> cardsData = overall.getListVaults().map((vault) {
      return VaultCardData(
        gradient: vault.gradient,
        name: vault.name,
        daysRemaining: vault.daysRemaining,
        image: vault.image,
        goalAmount: vault.goalAmount,
        balanceAmount: vault.balanceAmount,
        id: vault.id,
        isLocked: vault.isLocked,
      );
    }).toList();


    // TODO: DUMMY CARDS NEED TO BE REMOVED
    // cardsData.addAll([
    //   VaultCardData(
    //     gradient: LinearGradient(
    //       colors: [Color(0xFFEF07C8), Color(0xFF111735)],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //     ),
    //     name: 'Vault 1',
    //     daysRemaining: 30,
    //     image: Image.asset('assets/icons/icon_p.png'),
    //     goalAmount: 1000.0,
    //     balanceAmount: 500.0,
    //     id: 1,
    //     isLocked: true,
    //   ),
    //   VaultCardData(
    //     gradient: LinearGradient(
    //       colors: [Colors.indigo, Color(0xFF111735)],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //     ),
    //     name: 'Vault 2',
    //     daysRemaining: 60,
    //     image: Image.asset('assets/icons/icon_p.png'),
    //     goalAmount: 2000.0,
    //     balanceAmount: 1500.0,
    //     id: 2,
    //     isLocked: false,
    //   ),
    // ]);

    vaultCards = cardsData.map((data) => VaultCard(
      gradient: data.gradient,
      name: data.name,
      daysRemaining: data.daysRemaining,
      image: data.image,
      goalAmount: data.goalAmount,
      balanceAmount: data.balanceAmount,
      id: data.id,
      isLocked: data.isLocked,
    )).toList();

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
            // Title
            Positioned(
              top: 0,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Wallet',
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

            // + ADD Account Button
            Positioned(
              top: 70,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddVaultPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'ADD Vault',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Cards
            Positioned(
              top: 110,
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox.expand(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: kAnimationDuration,
                        height: totalHeightTotalCard(vaultCards.length),
                        width: MediaQuery.of(context).size.width,
                      ),
                      for (int i = 0; i < vaultCards.length; i++)
                        AnimatedPositioned(
                          top: _getCardTopPositioned(i, i == selectedCardIndex),
                          duration: kAnimationDuration,
                          child: Center(
                            child: AnimatedScale(
                              scale: _getCardScale(i, i == selectedCardIndex),
                              duration: kAnimationDuration,
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCardIndex = i;
                                    });
                                  },
                                  child: vaultCards[i],
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

            // Background box card
            // Positioned(
            //   top: 550,
            //   left: 0,
            //   right: 0,
            //   child: Center(
            //     child: Container(
            //       width: 550,
            //       height: 300,
            //       decoration: BoxDecoration(
            //         color: Color(0xFF0B0D4E),
            //         borderRadius: BorderRadius.circular(10),
            //         border: Border.all(
            //           color: Color(0x84050505),
            //           width: 3,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  double totalHeightTotalCard(int cardCount) {
    if (selectedCardIndex == null) {
      return kSpaceBetweenCard * (cardCount + 1) + kCardHeight * cardCount;
    } else {
      return kSpaceUnselectedCardToTop +
          kCardHeight +
          (cardCount - 2) * kSpaceBetweenUnselectCard +
          kSpaceBetweenCard;
    }
  }

  double _getCardTopPositioned(int index, bool isSelected) {
    if (selectedCardIndex != null) {
      if (isSelected) {
        return kSpaceBetweenCard;
      } else {
        return kSpaceUnselectedCardToTop +
            toUnselectedCardPositionIndex(index) * kSpaceBetweenUnselectCard;
      }
    } else {
      return kSpaceBetweenCard + index * kCardHeight + index * kSpaceBetweenCard;
    }
  }

  double _getCardScale(int index, bool isSelected) {
    if (selectedCardIndex != null) {
      if (isSelected) {
        return 1.0;
      } else {
        int totalUnselectCard = vaultCards.length - 1;
        return 1.0 -
            (totalUnselectCard - toUnselectedCardPositionIndex(index) - 1) *
                0.05;
      }
    } else {
      return 1.0;
    }
  }

  int toUnselectedCardPositionIndex(int indexInAllList) {
    if (selectedCardIndex != null) {
      if (indexInAllList < selectedCardIndex!) {
        return indexInAllList;
      } else {
        return indexInAllList - 1;
      }
    } else {
      throw 'Wrong usage';
    }
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:online_supermarket/models/card.dart';
import 'package:online_supermarket/progress_indicator.dart';
import 'package:online_supermarket/redux/action.dart';

import 'package:redux/redux.dart';
import 'package:online_supermarket/redux/state.dart';

const visaImagePath = 'assets/images/card/visa.png';
const masterCardImagePath = 'assets/images/card/mastercard.png';
const americanExpressImagePath = 'assets/images/card/american-express.png';
const maestroImagePath = 'assets/images/card/maestro.png';

class PaymentPageModel extends ChangeNotifier {
  PaymentPageModel({
    @required Store<AppState> store,
  }) : _store = store {}

  final Store<AppState> _store;

  String getCardImagePath(CardType cardType) {
    if (cardType == CardType.visa) {
      return visaImagePath;
    } else if (cardType == CardType.masterCard) {
      return masterCardImagePath;
    } else if (cardType == CardType.americanExpress) {
      return americanExpressImagePath;
    } else if (cardType == CardType.maestro) {
      return maestroImagePath;
    }
    return 'カード';
  }

  String getCardNumber(String cardNumber) {
    return 'XXXX-XXXX-${cardNumber.substring(10)}';
  }

  void onTapCard(int index) {
    print('onTapped');
    final card = _store.state.cardList[index];
    _store.dispatch(UpdateSelectedCardItemAction(cardItem: card));
    notifyListeners();
  }

  bool canProceedCheckOut() {
    for (final card in _store.state.cardList) {
      if (card.isSelected) {
        return true;
      }
    }
    return false;
  }

  Future<void> onTapProceedCheckOut(BuildContext context) async {
    LoadingOverlay.of(context).during(milliseconds: 2000);
    Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        return showDialog<AlertDialog>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'ご購入ありがとうございます。',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('支払いが正常に完了しました。'),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _resetStateAndGoHome(context);
                        },
                        child: const Text('ホーム画面へ戻る'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _resetStateAndGoHome(BuildContext context) {
    _store
      ..dispatch(EmptyCartAction(itemList: _store.state.itemList))
      ..dispatch(ResetTotalItemCountAction())
      ..dispatch(ResetTotalPriceAction())
      ..dispatch(ResetSelectedCardItemAction(cardList: _store.state.cardList));
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

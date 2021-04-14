import 'package:flutter/material.dart';
import 'package:online_supermarket/models/item.dart';
import 'package:online_supermarket/redux/action.dart';

import 'package:redux/redux.dart';
import 'package:online_supermarket/redux/state.dart';

class PaymentPageModel extends ChangeNotifier {
  PaymentPageModel({
    @required Store<AppState> store,
  }) : _store = store {
    _initialize();
  }

  final Store<AppState> _store;

  List<Item> _itemList;
  List<Item> get itemList => _itemList;

  bool _isCartEmpty;
  bool get isCartEmpty => _isCartEmpty;

  int _totalPrice;
  int get totalPrice => _totalPrice;

  int get totalItemCount => _store.state.totalSelectedItemCount;

  void _initialize() {
    _itemList = _store.state.itemList;
    _calculateSum();
    _checkIfCartIsEmpty();
  }

  void _calculateSum() {
    _totalPrice = 0;
    for (final item in _store.state.itemList) {
      _totalPrice += item.count * item.price;
    }
    notifyListeners();
  }

  void _checkIfCartIsEmpty() {
    _isCartEmpty = true;
    for (final item in _store.state.itemList) {
      if (item.count != 0) {
        _isCartEmpty = false;
      }
    }
    notifyListeners();
  }

  bool canProceedCheckOut() {
    if (_isCartEmpty) {
      return false;
    }
    return true;
  }

  void onTapIncrementIcon(int index) {
    _totalPrice += _store.state.itemList[index].price;
    _store
      ..dispatch(IncrementItemAction(updateItem: _store.state.itemList[index]))
      ..dispatch(IncrementTotalSelectedItemCountAction(
          totalItemSelectedCount: _store.state.totalSelectedItemCount));
    notifyListeners();
  }

  void onTapDecrementIcon(int index) {
    _totalPrice -= _store.state.itemList[index].price;
    _store
      ..dispatch(DecrementItemAction(updateItem: _store.state.itemList[index]))
      ..dispatch(DecrementTotalSelectedItemCountAction(
          totalItemSelectedCount: _store.state.totalSelectedItemCount));
    _checkIfCartIsEmpty();
    notifyListeners();
  }

  Future<void> onTapProceedCheckOut() {}

  void onTapEmptyCart() {
    _totalPrice = 0;
    _store
      ..dispatch(EmptyCartAction(itemList: _store.state.itemList))
      ..dispatch(ResetTotalSelectedItemCountAction(
          totalItemSelectedCount: _store.state.totalSelectedItemCount));
    notifyListeners();
  }
}

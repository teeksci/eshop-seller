import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellermultivendor/Provider/settingProvider.dart';
import '../Helper/Constant.dart';
import '../Widget/parameterString.dart';
import '../Model/getWithdrawelRequest/getWithdrawelmodel.dart';
import '../Repository/getWithdrawellRepositry.dart';

enum WalletStatus {
  initial,
  inProgress,
  isSuccsess,
  isFailure,
  isMoreLoading,
}

class WalletTransactionProvider extends ChangeNotifier {
  WalletStatus _transactionStatus = WalletStatus.initial;
  List<GetWithdrawelReq> userTransactions = [];
  String errorMessage = '';
  int transationListOffset = 0, _transactionPerPage = perPage;

  bool hasMoreData = false;

  get getCurrentStatus => _transactionStatus;

  changeStatus(WalletStatus status) {
    _transactionStatus = status;
    notifyListeners();
  }

  Future<void> getUserTransaction(BuildContext context) async {
    try {
      if (!hasMoreData) {
        changeStatus(WalletStatus.inProgress);
      }
      if(transationListOffset == 0){
        userTransactions.clear();
      }
      var parameter = {
        LIMIT: _transactionPerPage.toString(),
        OFFSET: transationListOffset.toString(),
      };
      Map<String, dynamic> result =
          await WithDrawelRepository.fetchUserWithDrawelReq(
              parameter: parameter);
      List<GetWithdrawelReq> tempList = [];

      for (var element in (result['transactionsList'] as List)) {
        tempList.add(element);
      }
      userTransactions.addAll(tempList);
      // userTransactions.addAll(tempList.reversed);

      if (int.parse(result['totalTransactions']) > transationListOffset) {
        transationListOffset += _transactionPerPage;
        hasMoreData = true;
      } else {
        hasMoreData = false;
      }
      changeStatus(WalletStatus.isSuccsess);
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      changeStatus(WalletStatus.isFailure);
      notifyListeners();
    }
  }
}

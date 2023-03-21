import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userpayment/model/sample.dart';
import 'balance_event.dart';
import 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc() : super(BalanceInitial());
  @override
  Stream<BalanceState> mapEventToState(BalanceEvent event) async* {
    if (event is GetBalancePerent) {
      yield* _getBalanceParent(event.parent, event.sampleName);
    }
  }

  Stream<BalanceState> _getBalanceParent(
      String parent, String sampleName) async* {
    try {
      final databalance = Sample.sampleAccounts;
      Map<String, dynamic> accountparent = {};
      List<Map<String, dynamic>> subaccountparent1 = [];
      List<Map<String, dynamic>> subaccountparent2 = [];
      List<Map<String, dynamic>> subaccountparent3 = [];
      List<Map<String, dynamic>> subaccountparent4 = [];
      List<Map<String, dynamic>> subaccountparent5 = [];
      Map<String, dynamic> alldatabalace = {};
      List<Map<String, dynamic>> listsubaccount = [];
      List subaccount = [];
      List subaccount2 = [];
      List subaccount3 = [];
      List subaccount4 = [];
      String parentaccount = parent;
      int total = 0;

      List<String> samplename = [];

      for (var element in databalance) {
        samplename.add(element.sampleName);
      }
      for (var element in databalance) {
        if (element.sampleName == sampleName) {
          if (element.accounts[0].parentAccountNo.isEmpty &&
              parent == element.rootAccountNo) {
            if (parent == element.accounts[0].accountNo) {
              listsubaccount.add(
                  {'total': total, 'account': element.accounts[0].accountNo});
              log('PARENT 1  ${element.accounts[0].accountNo} == ${parent}');
            }
          } else {
            for (var i = 0; i < element.accounts.length; i++) {
              final account = element.accounts[i];
              log('KESINI 1 ${element.accounts[0].parentAccountNo}');

              if (parent != element.rootAccountNo) {
                if (element.accounts[i].parentAccountNo == parentaccount) {
                  total = total + account.balance;
                  listsubaccount.add({
                    'total': total,
                    'account': element.accounts[i].accountNo
                  });
                  log('PARENT 1  ${element.accounts[i].parentAccountNo} == ${parent}');
                } else if (element.accounts[i].accountNo == parentaccount) {
                  total = total + account.balance;
                }
              } else if (parent == element.accounts[i].accountNo) {
                if (parent == element.rootAccountNo) {
                  if (element.accounts[i].parentAccountNo == parentaccount) {
                    total = total + account.balance;
                    listsubaccount.add({
                      'total': total,
                      'account': element.accounts[i].accountNo
                    });
                    log('PARENT 1  ${element.accounts[i].parentAccountNo} == ${parent}');
                  } else if (element.accounts[i].accountNo == parentaccount) {
                    total = total + account.balance;
                  }
                } else
                  log('PARENT 2  ${element.accounts[i].parentAccountNo} == ${parent}');

                total = total + account.balance;
              }
            }
          }

          accountparent.addAll({'${parentaccount}': listsubaccount});

          for (var i = 0; i < element.accounts.length; i++) {
            for (var itemsubaccount in listsubaccount) {
              if (itemsubaccount['account'] ==
                  element.accounts[i].parentAccountNo) {
                total = total + element.accounts[i].balance;

                subaccount.add(element.accounts[i].accountNo);

                if (subaccountparent1.isEmpty) {
                  subaccountparent1.add({
                    'parent': element.accounts[i].parentAccountNo,
                    'account': []..add(element.accounts[i].accountNo),
                    'balance': []..add(element.accounts[i].balance),
                    'total': 0,
                  });
                } else {
                  subaccountparent1.add({
                    'parent': element.accounts[i].parentAccountNo,
                    'account': []..add(element.accounts[i].accountNo),
                    'balance': []..add(element.accounts[i].balance),
                    'total': 0,
                  });
                }
              }
            }
          }

          for (var i = 0; i < element.accounts.length; i++) {
            for (var subsubacountitem in subaccount) {
              if (element.accounts[i].parentAccountNo == subsubacountitem) {
                subaccount2.add(element.accounts[i].accountNo);

                total = total + element.accounts[i].balance;
                if (subaccountparent2.isEmpty) {
                  subaccountparent2.add({
                    'parent': element.accounts[i].parentAccountNo,
                    'account': []..add(element.accounts[i].accountNo),
                    'balance': []..add(element.accounts[i].balance),
                    'total': 0,
                  });
                } else {
                  subaccountparent2.add({
                    'parent': element.accounts[i].parentAccountNo,
                    'account': []..add(element.accounts[i].accountNo),
                    'balance': []..add(element.accounts[i].balance),
                    'total': 0,
                  });
                }
              }
            }
          }
          for (var i = 0; i < element.accounts.length; i++) {
            for (var subsubsubaccountitem in subaccount2) {
              if (element.accounts[i].parentAccountNo == subsubsubaccountitem) {
                subaccount3.add(element.accounts[i].accountNo);

                total = total + element.accounts[i].balance;
                if (subaccountparent3.isEmpty) {
                  subaccountparent3.add({
                    'parent': element.accounts[i].parentAccountNo,
                    'account': []..add(element.accounts[i].accountNo),
                    'balance': []..add(element.accounts[i].balance),
                    'total': 0,
                  });
                } else {
                  subaccountparent3.add({
                    'parent': element.accounts[i].parentAccountNo,
                    'account': []..add(element.accounts[i].accountNo),
                    'balance': []..add(element.accounts[i].balance),
                    'total': 0,
                  });
                }
              }
            }
          }
          int totalsubparent4 = 0;
          for (var i = 0; i < element.accounts.length; i++) {
            for (var subsubsubaccountitem in subaccount3) {
              if (element.accounts[i].parentAccountNo == subsubsubaccountitem) {
                total = total + element.accounts[i].balance;
                subaccount4.add(element.accounts[i].accountNo);
                if (subaccountparent3.isEmpty) {
                  totalsubparent4 =
                      totalsubparent4 + element.accounts[i].balance;
                  log('BALANCE PARENT 4 ${totalsubparent4}  ');

                  subaccountparent4.add({
                    'parent': element.accounts[i].parentAccountNo,
                    'account': []..add(element.accounts[i].accountNo),
                    'balance': []..add(element.accounts[i].balance),
                    'total': total,
                  });
                } else {
                  totalsubparent4 =
                      totalsubparent4 + element.accounts[i].balance;
                  log('BALANCE PARENT 4 ${totalsubparent4}  ');
                  subaccountparent4.add({
                    'parent': element.accounts[i].parentAccountNo,
                    'account': []..add(element.accounts[i].accountNo),
                    'balance': []..add(element.accounts[i].balance),
                    'total': total,
                  });
                }
              }
            }
          }

          for (var i = 0; i < element.accounts.length; i++) {
            for (var subsubsubsubaccountitem in subaccount4) {
              if (element.accounts[i].parentAccountNo ==
                  subsubsubsubaccountitem) {
                total = total + element.accounts[i].balance;

                if (subaccountparent3.isEmpty) {
                  subaccountparent5.add({
                    'parent': element.accounts[i].parentAccountNo,
                    'account': []..add(element.accounts[i].accountNo),
                    'balance': []..add(element.accounts[i].balance),
                    'total': total,
                  });
                } else {
                  subaccountparent5.add({
                    'parent': element.accounts[i].parentAccountNo,
                    'account': []..add(element.accounts[i].accountNo),
                    'balance': []..add(element.accounts[i].balance),
                    'total': total,
                  });
                }
              }
            }
          }
        }
      }

      alldatabalace.addAll({'account': listsubaccount});

      log('ACCOUNT ${listsubaccount} ');
      log('SUBACCOUNT ${subaccountparent1} ');
      log('SUBSUBACCOUNT ${subaccountparent2} ');
      log('SUBSUBSUBACCOUNT ${subaccountparent3} ');
      log('SUBSUBSUBACCOUNT ${subaccountparent5} ');
      log('BALANCE ${total}  ');
      yield GetBalanceAllState(
          accountparent,
          subaccountparent1,
          subaccountparent2,
          subaccountparent3,
          subaccountparent4,
          subaccountparent5);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

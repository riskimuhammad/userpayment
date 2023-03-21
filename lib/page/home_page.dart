import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userpayment/bloc/balance_bloc.dart';
import 'package:userpayment/bloc/balance_event.dart';
import 'package:userpayment/bloc/balance_state.dart';
import 'package:userpayment/model/sample.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DropdownMenuItem<String>> _sample = [];
  List<String> _account = [];
  String? _sampleselected;
  String? _accountselected;
  Map<String, dynamic> accountparent = {};
  List subaccountparent1 = [];
  List subaccountparent2 = [];
  List subaccountparent3 = [];
  List subaccountparent4 = [];
  List subaccountparent5 = [];
  int jumsubaccountparent1 = 0;
  int jumsubaccountparent2 = 0;
  int jumsubaccountparent3 = 0;
  int jumsubaccountparent4 = 0;
  int jumsubaccountparent5 = 0;
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    for (var i = 0; i < Sample.sampleAccounts.length; i++) {
      _sample.add(DropdownMenuItem(
          value: Sample.sampleAccounts[i].sampleName,
          child: Text(Sample.sampleAccounts[i].sampleName)));
    }
    setState(() {});
  }

  _filteraccount() {
    final List<String> _accounttmp = [];

    for (var i = 0; i < Sample.sampleAccounts.length; i++) {
      if (Sample.sampleAccounts[i].sampleName == _sampleselected) {
        for (var element in Sample.sampleAccounts[i].accounts) {
          _accounttmp.add(element.accountNo);
        }
      }
    }
    _account.addAll(_accounttmp.toList().toSet().toList());
    _account.sort((a, b) => a.compareTo(b));
    debugPrint(_account.toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BalanceBloc, BalanceState>(listener: (context, state) {
      if (state is GetBalanceAllState) {
        accountparent.addAll(state.accountparent);
        subaccountparent1.addAll(state.subaccountparent1);
        subaccountparent2.addAll(state.subaccountparent2);
        subaccountparent3.addAll(state.subaccountparant3);
        subaccountparent4.addAll(state.subaccountparant4);
        subaccountparent5.addAll(state.subaccountparant5);
        _ceksubaccount();
      }
    }, builder: (context, snapshot) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Balance Aggregator'),
          ),
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text('Select Sample : '),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _sampleselected,
                          items: _sample,
                          onChanged: (val) {
                            _account.clear();
                            _accountselected = null;
                            _sampleselected = val;
                            accountparent.clear();
                            subaccountparent1.clear();
                            subaccountparent2.clear();
                            subaccountparent3.clear();
                            _filteraccount();
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text('Select Account : '),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _accountselected,
                          items: _account
                              .map((e) => DropdownMenuItem<String>(
                                  value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) {
                            _accountselected = val;
                            accountparent.clear();
                            subaccountparent1.clear();
                            subaccountparent2.clear();
                            subaccountparent3.clear();
                            subaccountparent4.clear();
                            subaccountparent5.clear();

                            BlocProvider.of<BalanceBloc>(context).add(
                                GetBalancePerent(
                                    _accountselected!, _sampleselected!));
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_accountselected != null)
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: accountparent[_accountselected].length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('+ Acc ' +
                              accountparent[_accountselected][index]
                                  ['account'] +
                              '=' +
                              accountparent[_accountselected][index]['total']
                                  .toString()),
                          if (subaccountparent1.isNotEmpty)
                            _subaccountsetting(
                                subaccountparent1,
                                accountparent[_accountselected][index]
                                    ['account']),
                        ],
                      );
                    },
                  ),
                )
            ],
          ));
    });
  }

  _subaccountsetting(List<dynamic> subaccount, String parentAccount) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: subaccount.length,
      itemBuilder: (context, indexparent) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            left: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subaccount[indexparent]['parent'] == parentAccount
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: subaccount[indexparent]['account'].length,
                      itemBuilder: (context, indexsub) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('+ Acc ' +
                                subaccount[indexparent]['account'][indexsub] +
                                '=' +
                                subaccount[indexparent]['balance'][indexsub]
                                    .toString()),
                            if (subaccountparent2.isNotEmpty)
                              _subaccountsettingke2(
                                  parentAccount: subaccount[indexparent]
                                      ['account'][indexsub],
                                  subaccount: subaccountparent2,
                                  subaccount3: subaccountparent3)
                          ],
                        );
                      },
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }

  _subaccountsettingke2({
    List<dynamic>? subaccount,
    String? parentAccount,
    List<dynamic>? subaccount3,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: subaccount!.length,
      itemBuilder: (context, indexparent) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            left: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subaccount[indexparent]['parent'] == parentAccount
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: subaccount[indexparent]['account'].length,
                      itemBuilder: (context, indexsub) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('+ Acc ' +
                                subaccount[indexparent]['account'][indexsub] +
                                '=' +
                                subaccount[indexparent]['balance'][indexsub]
                                    .toString()),
                            if (subaccountparent3.isNotEmpty)
                              _subaccountsettingke3(
                                  parentAccount: subaccount[indexparent]
                                      ['account'][indexsub],
                                  subaccount4: subaccountparent4,
                                  subaccount: subaccount3)
                          ],
                        );
                      },
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }

  _subaccountsettingke3({
    List<dynamic>? subaccount,
    String? parentAccount,
    List<dynamic>? subaccount4,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: subaccount!.length,
      itemBuilder: (context, indexparent) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            left: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subaccount[indexparent]['parent'] == parentAccount
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: subaccount[indexparent]['account'].length,
                      itemBuilder: (context, indexsub) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('+ Acc ' +
                                subaccount[indexparent]['account'][indexsub] +
                                '=' +
                                subaccount[indexparent]['balance'][indexsub]
                                    .toString()),
                            if (subaccountparent4.isNotEmpty)
                              _subaccountsettingke4(
                                parentAccount: subaccount[indexparent]
                                    ['account'][indexsub],
                                subaccount: subaccount4,
                                subaccount5: subaccountparent5,
                              )
                          ],
                        );
                      },
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }

  _subaccountsettingke4({
    List<dynamic>? subaccount,
    String? parentAccount,
    List<dynamic>? subaccount5,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: subaccount!.length,
      itemBuilder: (context, indexparent) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            left: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subaccount[indexparent]['parent'] == parentAccount
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: subaccount[indexparent]['account'].length,
                      itemBuilder: (context, indexsub) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('+ Acc ' +
                                subaccount[indexparent]['account'][indexsub] +
                                '=' +
                                subaccount[indexparent]['total'].toString()),
                            if (subaccountparent5.isNotEmpty)
                              _subaccountsettingke5(
                                  parentAccount: subaccount[indexparent]
                                      ['account'][indexsub],
                                  subaccount: subaccount5)
                          ],
                        );
                      },
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }

  _subaccountsettingke5({
    List<dynamic>? subaccount,
    String? parentAccount,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: subaccount!.length,
      itemBuilder: (context, indexparent) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            left: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subaccount[indexparent]['parent'] == parentAccount
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: subaccount[indexparent]['account'].length,
                      itemBuilder: (context, indexsub) {
                        jumsubaccountparent5 = jumsubaccountparent5 +
                            subaccount[indexparent]['balance'][indexsub] as int;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('+ Acc ' +
                                subaccount[indexparent]['account'][indexsub] +
                                '=' +
                                subaccount[indexparent]['total'].toString()),
                          ],
                        );
                      },
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }

  _ceksubaccount() {
    for (var i = 0; i < accountparent[_accountselected].length; i++) {
      if (subaccountparent1.isNotEmpty) {
        for (var parentsubindex1 = 0;
            parentsubindex1 < subaccountparent1.length;
            parentsubindex1++) {
          //CEK SUB ACCOUNT 1
          if (accountparent[_accountselected][i]['account'] ==
              subaccountparent1[parentsubindex1]['parent']) {
            for (var subindex1 = 0;
                subindex1 <
                    subaccountparent1[parentsubindex1]['account'].length;
                subindex1++) {
              //JUMLAH TOTAL UNTUK PARENT YANG DI PILIH
              subaccountparent1[parentsubindex1]['total'] +=
                  subaccountparent1[parentsubindex1]['balance'][subindex1];
              //CEK SUB ACCOUNT KE 2
              if (subaccountparent2.isNotEmpty) {
                for (var parentsubindex2 = 0;
                    parentsubindex2 < subaccountparent2.length;
                    parentsubindex2++) {
                  if (subaccountparent1[parentsubindex1]['account']
                          [subindex1] ==
                      subaccountparent2[parentsubindex2]['parent']) {
                    for (var subindex2 = 0;
                        subindex2 <
                            subaccountparent2[parentsubindex2]['account']
                                .length;
                        subindex2++) {
                      //TOTAL PARENT KE 2 SUB PARENT 1
                      subaccountparent2[parentsubindex2]['total'] +=
                          subaccountparent2[parentsubindex2]['balance']
                              [subindex2];
                      //TOTAL PARENT 1 HASIL DARI SUBSUB NYA
                      subaccountparent1[parentsubindex1]['total'] +=
                          subaccountparent2[parentsubindex2]['balance']
                              [subindex2];
                      //CEK PARENT KR 3 SUB PARENT 2
                      if (subaccountparent3.isNotEmpty) {
                        for (var parentsubindex3 = 0;
                            parentsubindex3 < subaccountparent3.length;
                            parentsubindex3++) {
                          if (subaccountparent2[parentsubindex2]['account']
                                  [subindex2] ==
                              subaccountparent3[parentsubindex3]['parent']) {
                            if (subaccountparent3[parentsubindex3]['acount'] !=
                                null) {
                              for (var subindex3 = 0;
                                  subindex3 <
                                      subaccountparent3[parentsubindex3]
                                              ['acount']
                                          .length;
                                  subindex3++) {
                                //TOTAL PARENT 1 HASIL DARI SUB SUB SUB NYA
                                subaccountparent1[parentsubindex1]['total'] +=
                                    subaccountparent3[parentsubindex3]
                                        ['balance'][subindex3];
                                //TOTAL PARENT 2 HASIL DARI SUB SUB NYA
                                subaccountparent2[parentsubindex2]['total'] +=
                                    subaccountparent3[parentsubindex3]
                                        ['balance'][subindex3];
                                //TOTAL PARENT 3 DARI SUB NYA
                                subaccountparent3[parentsubindex3]['total'] +=
                                    subaccountparent3[parentsubindex3]
                                        ['balance'][subindex3];
                                //CEK PARENT KE 4
                                if (subaccountparent4.isNotEmpty) {
                                  for (var parentsubindex4 = 0;
                                      parentsubindex4 <
                                          subaccountparent4.length;
                                      parentsubindex4++) {
                                    if (subaccountparent3[parentsubindex3]
                                            ['account'][subindex3] ==
                                        subaccountparent4[parentsubindex4]
                                            ['parent']) {
                                      if (subaccountparent4[parentsubindex4]
                                              ['account'] !=
                                          null) {
                                        for (var subindex4 = 0;
                                            subindex4 <
                                                subaccountparent4[
                                                            parentsubindex4]
                                                        ['account']
                                                    .length;
                                            subindex4++) {
                                          //TOTAL PARENT 1 DARI SUB SUB SUB SUB NYA
                                          subaccountparent1[parentsubindex1]
                                                  ['total'] +=
                                              subaccountparent4[parentsubindex4]
                                                  ['balance'][subindex4];
                                          //TOTAL PARENY 2 DARI SUB SUB SUB NYA
                                          subaccountparent2[parentsubindex2]
                                                  ['total'] +=
                                              subaccountparent4[parentsubindex4]
                                                  ['balance'][subindex4];
                                          //TOTAL PARENT 3 DARI SUB SUB NYA
                                          subaccountparent3[parentsubindex3]
                                                  ['total'] +=
                                              subaccountparent4[parentsubindex4]
                                                  ['balance'][subindex4];
                                          //TOTAL PARENY 4 DARI SUB NYA
                                          subaccountparent4[parentsubindex4]
                                                  ['total'] +=
                                              subaccountparent4[parentsubindex4]
                                                  ['balance'][subindex4];

                                          //CEK PARENT 5
                                          if (subaccountparent5.isNotEmpty) {
                                            for (var parentsubindex5 = 0;
                                                parentsubindex5 <
                                                    subaccountparent5.length;
                                                parentsubindex5++) {
                                              if (subaccountparent5[
                                                          parentsubindex5]
                                                      ['parent'] ==
                                                  subaccountparent4[
                                                          parentsubindex4]
                                                      ['account'][subindex4]) {
                                                for (var subindex5 = 0;
                                                    subindex5 <
                                                        subaccountparent5[
                                                                    parentsubindex5]
                                                                ['account']
                                                            .length;
                                                    subindex5++) {
                                                  //TOTAL PARENT 1 DARI SUB SUB SUB SUB SUB NYA
                                                  subaccountparent1[
                                                              parentsubindex1]
                                                          ['total'] +=
                                                      subaccountparent5[
                                                              parentsubindex5][
                                                          'balance'][subindex5];
                                                  //TOTAL PARENT 2 DARI SUB SUB SUB SUB NYA
                                                  subaccountparent2[
                                                              parentsubindex2]
                                                          ['total'] +=
                                                      subaccountparent5[
                                                              parentsubindex5][
                                                          'balance'][subindex5];
                                                  //TOTSL PARENT 3 DARI SUB SUB SUB NYA
                                                  subaccountparent3[
                                                              parentsubindex3]
                                                          ['total'] +=
                                                      subaccountparent5[
                                                              parentsubindex5][
                                                          'balance'][subindex5];
                                                  //TOTAL PARENT 4 DARI SUB SUB NYA
                                                  subaccountparent4[
                                                              parentsubindex4]
                                                          ['total'] +=
                                                      subaccountparent5[
                                                              parentsubindex5][
                                                          'balance'][subindex5];
                                                  //TOTAL PARENT 5 DARI SUB NYA
                                                  subaccountparent5[
                                                              parentsubindex5]
                                                          ['total'] +=
                                                      subaccountparent5[
                                                              parentsubindex5][
                                                          'balance'][subindex5];
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          debugPrint(
              'total dari ${subaccountparent1[parentsubindex1]['parent']} = ${subaccountparent1[parentsubindex1]['total']}');
        }
      }
    }
  }
}

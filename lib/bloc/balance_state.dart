import 'package:equatable/equatable.dart';

abstract class BalanceState extends Equatable {}

class BalanceInitial implements BalanceState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class GetBalanceAllState implements BalanceState {
  final Map<String, dynamic> accountparent;
  final List subaccountparent1;
  final List subaccountparent2;
  final List subaccountparant3;
  final List subaccountparant4;
  final List subaccountparant5;
  GetBalanceAllState(
      this.accountparent,
      this.subaccountparent1,
      this.subaccountparent2,
      this.subaccountparant3,
      this.subaccountparant4,
      this.subaccountparant5);
  @override
  List<Object?> get props =>
      [accountparent, subaccountparent1, subaccountparent2, subaccountparant3];

  @override
  bool? get stringify => false;
}

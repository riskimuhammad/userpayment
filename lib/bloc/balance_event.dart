import 'package:equatable/equatable.dart';

abstract class BalanceEvent extends Equatable {}

class GetBalancePerent implements BalanceEvent {
  final String parent;
  final String sampleName;
  GetBalancePerent(this.parent, this.sampleName);
  @override
  List<Object?> get props => [parent, sampleName];

  @override
  bool? get stringify => false;
}

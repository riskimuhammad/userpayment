import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userpayment/bloc/balance_bloc.dart';
import 'package:userpayment/page/home_page.dart';

void main() {
  runApp(const UserPayment());
}

class UserPayment extends StatelessWidget {
  const UserPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => BalanceBloc())],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

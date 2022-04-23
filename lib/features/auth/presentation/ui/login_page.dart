import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth/commen/util/injectable/injectable_init.dart';
import 'package:flutter_firebase_auth/features/auth/presentation/bloc/signin/login_cubit.dart';
import 'package:flutter_firebase_auth/features/auth/presentation/ui/widgets/login/login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login Page')),
        body: const LoginWidget(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaapp/cubit/cubit/authtecate_cubit.dart';
import 'package:instaapp/view/buttombar.dart';
import 'package:instaapp/widget/loginform.dart';
import 'package:instaapp/widget/rowcheck.dart';
import 'package:instaapp/widget/stackaddphoto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthtecateCubit(),
      child: BlocConsumer<AuthtecateCubit, AuthtecateState>(
        listener: (context, state) {
          if (state is AuthtecateSuccessstate) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BottomBarpage(),
              ),
            );
          } else if (state is AuthtecateErrorstate) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: state is AuthtecateLoadingstate
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        Text('Login'),
                      loginformfield(),
                        rowcheck(anotherpage: 'register'),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

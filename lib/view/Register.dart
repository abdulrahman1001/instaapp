import 'package:flutter/material.dart';
import 'package:instaapp/cubit/cubit/authtecate_cubit.dart';
import 'package:instaapp/view/buttombar.dart';
import 'package:instaapp/widget/registerform.dart';
import 'package:instaapp/widget/rowcheck.dart';
import 'package:instaapp/widget/stackaddphoto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registerpage extends StatelessWidget {
  const Registerpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthtecateCubit(),
      child: BlocConsumer<AuthtecateCubit, AuthtecateState>(
        listener: (context, state) {
          if (state is AuthtecateSuccessstate) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => BottomBarpage(),
            ));
          }

          if (state is AuthtecateErrorstate) {
               print(state.error);
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
                        Text('insta app'),
                        StackAddPhoto(),
                        formfield(),
                        rowcheck(
                          anotherpage: 'login',
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

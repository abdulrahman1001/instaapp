import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instaapp/cubit/cubit/authtecate_cubit.dart';
import 'package:instaapp/widget/textfeildpasswordform.dart';
import 'package:instaapp/widget/textfieldemailform.dart';
import 'package:instaapp/widget/textfieldusernameform.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class formfield extends StatefulWidget {
  const formfield({super.key});

  @override
  State<formfield> createState() => _formfieldState();
}

class _formfieldState extends State<formfield> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey();
    String email = 'd@dd';
    String password = 'dddddddddddddddd';
    String name = '';
    return Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              textfieldusernameform(
                onChanged: (p0) {
                  name = p0;
                },
              ),
              textfieldemailform(
                onChanged: (p0) {
                  email = p0;
                },
              ),
              textfieldpasswpdform(
                onChanged: (p0) {
                  password = p0;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      await BlocProvider.of<AuthtecateCubit>(context)
                          .createUser(
                        email,
                        password,
                        name
                      );
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ));
  }
}

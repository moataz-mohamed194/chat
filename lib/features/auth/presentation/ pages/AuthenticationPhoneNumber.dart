// port 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart' as di;

import '../../ domain/entities/login.dart';
import '../../../../core/widgets/ButtonWidget.dart';
import '../../../../core/widgets/TextFormFieldWidgets.dart';
import '../../../home/presentation/ pages/get_all_weight.dart';
import '../../data/datasources/login_remote_date_source.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class AuthenticationPhoneNumber extends StatelessWidget {
  final TextEditingController _phoneValidationController =
      TextEditingController();
  final Login? login;
  final _formKey = GlobalKey<FormState>();

  AuthenticationPhoneNumber({super.key, this.login});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<LoginBloc>(
            create: (context) => di.sl<LoginBloc>()
              ..add(VerificationUserEvent(login: this.login!)),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Add authentication code",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 17),
                        ),
                        TextFormFieldWidgets(
                          hintText: 'Code',
                          keyboardType: TextInputType.phone,
                          controler: _phoneValidationController,
                          rightWidget: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _phoneValidationController.clear();
                            },
                          ),
                          validatorTextField: (value) {},
                        ),
                        ButtonWidget(
                            text: 'Activate account',
                            action: () async {
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                verificationId: verification,
                                smsCode: _phoneValidationController.text,
                              );
                              FirebaseAuth auth = FirebaseAuth.instance;
                              print("credential: ${credential}");
                              await auth
                                  .signInWithCredential(credential)
                                  .then((value) {
                                BlocProvider.of<LoginBloc>(context)
                                    .add(AddUserEvent(login: login!));
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (_) => MainUserPage()),
                                        (route) => false);

                              });})
                      ]),
                );
              },
            )));
  }
}

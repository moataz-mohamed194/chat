import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ pages/CreateAccountPage.dart';
import '../../ domain/entities/login.dart';
import '../../ domain/validation/validator.dart';
import '../../../../core/widgets/ButtonWidget.dart';
import '../../../../core/widgets/TextFormFieldWidgets.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../eyesBloc/CheckerCubit.dart';

class LoginFormWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidgets(
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            controler: _emailController,
            validatorTextField: (val) => Validator().validatorEmail(val),
          ),
          BlocBuilder<CheckerCubit, bool>(
            builder: (context, state) {
              return TextFormFieldWidgets(
                hintText: 'password',
                keyboardType: TextInputType.text,
                rightWidget: IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    context.read<CheckerCubit>().changeCheck();
                  },
                ),
                obscureText: state,
                controler: _passwordController,
                validatorTextField: (val) => Validator().validatorPassword(val),
              );
            },
          ),
          ButtonWidget(
              text: 'Login',
              action: () {
                validateFormThenUpdateOrAddPost(context);
              })
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost(BuildContext context) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final login = Login(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString(),
      );

      BlocProvider.of<LoginBloc>(context).add(LoginMethodEvent(login: login));
    }
  }
}

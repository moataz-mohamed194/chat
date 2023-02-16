import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../home/presentation/ pages/get_all_weight.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../widgets/signup_form_widget2.dart';
import 'AuthenticationPhoneNumber.dart';

class CreateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF6F3EC),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Color(0xff2891F8),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Create an Account',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _body(context),
    ));
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is MessageLoginState) {
              SnackBarMessage()
                  .showSuccesSnackBar(message: state.message, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => MainUserPage()),
                  (route) => false);
            } else if (state is ErrorLoginState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            // if (state is LoadingLoginState) {
            //   return LoadingWidget();
            // }
            return SignUpFormWidget();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextFormFieldWidgets extends StatelessWidget{
  final String hintText;
  final TextEditingController controler;
  final Widget? rightWidget;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator validatorTextField;

  const TextFormFieldWidgets({super.key,this.rightWidget,this.obscureText,this.keyboardType, required this.hintText, required this.controler, required this.validatorTextField});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controler,
        keyboardType: keyboardType,
        validator: (val) => validatorTextField(val),
        decoration: InputDecoration(
          filled: true,
          suffixIcon: rightWidget,
          fillColor: Colors.white,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black26, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black26, width: 0),
          ),
        ),
          obscureText:obscureText??false
      ),
    );
  }

}
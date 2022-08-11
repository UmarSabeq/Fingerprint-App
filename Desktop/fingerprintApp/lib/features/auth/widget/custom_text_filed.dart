import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final Widget? showPasswordWidget;
  final String hint;
  final bool password;
  final IconData icon;
  final String validat;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmit;

  const CustomTextFiled({
    Key? key,
    required this.controller,
    required this.textInputType,
    this.showPasswordWidget,
    required this.hint,
    required this.password,
    required this.icon,
    required this.validat,
    this.initialValue,
    this.textInputAction,
    this.onSubmit,
  }) : super(key: key);

  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: widget.password,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onSubmit,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.showPasswordWidget,
        errorMaxLines: 5,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: widget.hint,
        labelText: widget.hint,
      ),
      validator: (value) => value!.isEmpty ? widget.validat : null,
    );
  }
}

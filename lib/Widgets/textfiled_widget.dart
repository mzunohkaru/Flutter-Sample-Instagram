import 'package:flutter/material.dart';

class RegistrationTextFieldWidget extends StatelessWidget {
  const RegistrationTextFieldWidget(
      {super.key,
      required this.mailController,
      required this.labelText,
      required this.iconData});

  final TextEditingController mailController;
  final String labelText;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: mailController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          filled: true,
          prefixIcon: Icon(iconData),
          labelText: labelText,
        ),
      ),
    );
  }
}

class PasswordTextFiledWidget extends StatelessWidget {
  const PasswordTextFiledWidget({
    super.key,
    required this.passwordController,
    required this.obscure,
    required this.labelText,
  });

  final TextEditingController passwordController;
  final ValueNotifier<bool> obscure;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: passwordController,
        obscureText: obscure.value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          filled: true,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: () {
              obscure.value = !obscure.value;
            },
            icon: Icon(obscure.value ? Icons.visibility_off : Icons.visibility),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}

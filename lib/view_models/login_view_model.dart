import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/show_snack_bar.dart';

class LoginViewModel {
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  bool _obscure = true;

  get formKey => _formKey;

  get emailController => _emailController;

  get passwordController => _passwordController;

  get loading => _loading;

  get obscure => _obscure;

  setObscure() {
    _obscure = !_obscure;
  }

  setLoading(bool change) {
    _loading = change;
  }

  Future<void> userLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      /// todo: Perform login logic here
      ShowSnackBar.getSnackBar(context, 'Logging in...');
      await Supabase.instance.client.auth
          .signInWithPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) {
        // 0n successfully creating account
        Navigator.pushReplacementNamed(context, '/onboarding');
      }).onError(
        (error, stackTrace) {
          // on Failing to create account
          // error occur while creating account
          ShowSnackBar.getSnackBar(context, 'Something went wrong!');
        },
      );
    }
  }
}

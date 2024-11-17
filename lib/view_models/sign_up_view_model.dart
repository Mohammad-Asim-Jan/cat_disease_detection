import 'package:cat_disease_detection/view_models/profile_view_model.dart';
import 'package:cat_disease_detection/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/show_snack_bar.dart';

class SignUpViewModel {
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Supabase supabase = Supabase.instance;

  bool _loading = false;
  bool _obscure1 = true;
  bool _obscure2 = true;

  get formKey => _formKey;

  get emailController => _emailController;

  get passwordController => _passwordController;

  get confirmPasswordController => _confirmPasswordController;

  get loading => _loading;

  get obscure1 => _obscure1;

  get obscure2 => _obscure2;

  setObscure1() {
    _obscure1 = !_obscure1;
  }

  setObscure2() {
    _obscure2 = !_obscure2;
  }

  setLoading(bool change) {
    _loading = change;
  }

  Future<void> createUserAccountInSupabase(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      ShowSnackBar.getSnackBar(context, 'Creating account...');
      ProfileViewModel profileViewModel = ProfileViewModel();
      final auth = supabase.client.auth;
      await auth.signUp(email: email, password: password).then(
        (value) async {
          String userName = extractUsername(email);
          // 0n successfully creating account
          await profileViewModel.addUserProfile(
              context, auth.currentUser!.id, userName, email, null);
          await ShowSnackBar.getSnackBar(context, 'Account Created Successfully!');
          Navigator.pop(context);
        },
      ).onError(
        (error, stackTrace) {
          debugPrint('Error: $error');
          // on Failing to create account
          // error occur while creating account
          ShowSnackBar.getSnackBar(context, error.toString());
        },
      );
    }
  }

  // Get the name from the email address
  String extractUsername(String email) {
    // Find the index of the '@' character
    int atIndex = email.indexOf('@');

    // If the '@' character is found, return the substring before it
    if (atIndex != -1) {
      return email.substring(0, atIndex);
    }

    // Return an empty string if the email format is invalid
    return '';
  }
}

import 'package:cat_disease_detection/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../views/login_view.dart';

class HomeViewModel {
  logout(BuildContext context) {
    Supabase.instance.client.auth.signOut().then((value) {
      ShowSnackBar.getSnackBar(context, 'Signing out!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView()));
    }).onError((error, stackTrace) {
      ShowSnackBar.getSnackBar(context, 'Error!');
    });
  }
}

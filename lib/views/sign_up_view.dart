// Sign Up View
import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../view_models/sign_up_view_model.dart';
import '../widgets/round_button.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late SignUpViewModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = SignUpViewModel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.mainColor,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16.0, top: 70, bottom: 16.0),
                child: Form(
                  key: model.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        // Email TextField
                        TextFormField(
                          controller: model.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        // Password TextField
                        TextFormField(
                          controller: model.passwordController,
                          obscureText: model.obscure1,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  model.setObscure1();
                                });
                              },
                              icon: Icon(model.obscure1
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        // Confirm Password TextField
                        TextFormField(
                          controller: model.confirmPasswordController,
                          obscureText: model.obscure2,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  model.setObscure2();
                                });
                              },
                              icon: Icon(model.obscure2
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter confirm password';
                            } else if (value != model.passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        // Sign Up Button
                        RoundButton(
                          title: 'Sign Up',
                          loading: model.loading,
                          onPress: () {
                            setState(() {
                              model.setLoading(true);
                            });
                            model.createUserAccountInSupabase(context);
                            Timer(
                              const Duration(seconds: 1),
                              () {
                                setState(() {
                                  model.setLoading(false);
                                });
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 8.0),
                        // Navigate back to Login Page
                        // TextButton(
                        //   onPressed: () {
                        //     Navigator.pop(context); // Go back to login page
                        //   },
                        //   child: const Text('Already have an account? Login'),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

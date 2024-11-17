import 'dart:async';
import '../utils/constants.dart';
import 'package:flutter/material.dart';
import '../view_models/login_view_model.dart';
import '../widgets/round_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = LoginViewModel();
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
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text(
              'Register',
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
          onPressed: () {},
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
              'Login',
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
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: model.formKey, // Form key
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Email TextField
                      TextFormField(
                        controller: model.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          // Adds a border to the TextField
                          prefixIcon: Icon(Icons
                              .email), // Icon at the start of the TextField
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
                        obscureText: model.obscure,
                        // Hides the password for security
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  model.setObscure();
                                });
                              },
                              icon: Icon(model.obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          prefixIcon: const Icon(
                              Icons.lock), // Icon at the start of the TextField
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
                      // Login Button
                      RoundButton(
                        title: 'Login',
                        loading: model.loading,
                        onPress: () {
                          setState(() {
                            model.setLoading(true);
                          });
                          model.userLogin(context);
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
                      // Navigate to SignUp Page
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (context) {
                      //         return SignUpView();
                      //       }),
                      //     );
                      //   },
                      //   child: const Text('Don’t have an account? Sign Up'),
                      // ),
                    ],
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

// import 'package:cats_disease_detection/widgets/custom_text_field.dart';
// import 'package:cats_disease_detection/widgets/round_button.dart';
// import 'package:flutter/material.dart';
//
// class LogIn extends StatefulWidget {
//   const LogIn({super.key});
//
//   @override
//   State<LogIn> createState() => _LogInState();
// }
//
// class _LogInState extends State<LogIn> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   TextEditingController emailC = TextEditingController();
//   TextEditingController passwordC = TextEditingController();
//
//   bool _loading = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Spacer(),
//             const Text(
//               'Login',
//               style: TextStyle(
//                 // color: Colors.black,
//                 fontSize: 33,
//                 wordSpacing: 2,
//                 letterSpacing: 3,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(
//               height: 70,
//             ),
//             SizedBox(
//               height: 155,
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     CustomTextField(
//                       controller: emailC,
//                       textInputType: TextInputType.emailAddress,
//                       iconData: Icons.email_outlined,
//                       hint: 'Email',
//                       validatorText: 'Please provide email',
//                     ),
//                     CustomTextField(
//                       controller: passwordC,
//                       textInputType: TextInputType.emailAddress,
//                       iconData: Icons.lock_outline_rounded,
//                       hint: 'Password',
//                       validatorText: 'Please provide password',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const Spacer(),
//             RoundButton(
//               title: 'Log In',
//               loading: _loading,
//               onPress: () {
//                 setState(() {
//                   _loading = true;
//                 });
//
//                 ///todo: login logic
//
//                 Future.delayed(
//                   const Duration(seconds: 2),
//                   () {
//                     setState(() {
//                       _loading = false;
//                     });
//                   },
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Don\'t have an account?   ',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                 ),
//                 RoundButton(
//                   title: 'Sign Up',
//                   onPress: () {
//                     // Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     //     builder: (context) => const SignUp()));
//                   },
//                   unFill: true,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

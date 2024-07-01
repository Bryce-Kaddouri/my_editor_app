import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide FilledButton, Colors;
import 'package:go_router/go_router.dart';
import 'package:my_editor_app/src/features/authentication/data/datasource/auth_datasource.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(children: [
        Positioned(
          child: Container(
            height: 150,
            width: 100,
            color: Colors.blue,
          ),
          top: 10,
          left: 10,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Container(
            height: 120,
            width: 120,
            color: Colors.magenta,
          ),
        ),
        Positioned(
          child: Container(
            height: 150,
            width: 100,
            color: Colors.yellow,
          ),
          bottom: 10,
          right: 10,
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Acrylic(
            blurAmount: 30,
            tintAlpha: 0.5,
            luminosityAlpha: 0.5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormBox(
                      controller: emailController,
                      placeholder: 'Email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormBox(
                      controller: passwordController,
                      placeholder: 'Password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(color: FluentTheme.of(context).accentColor, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("sign up tapped");

                                context.push('/signup');
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    Container(
                      width: double.infinity,
                      child: FilledButton(
                        child: Text('Sign in'),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // sign in
                            final res = await AuthenticationDataSource().signInWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );

                            res.fold(
                              (l) {
                                print('error: ${l.errorMessage}');
                              },
                              (r) {
                                print('success: $r');
                                context.push('/otp');
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ])),
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:go_router/go_router.dart';
import 'package:my_editor_app/src/features/authentication/data/datasource/auth_datasource.dart';
import 'package:my_editor_app/src/features/authentication/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
                        placeholder: 'Email',
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormBox(
                        placeholder: 'Password',
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormBox(
                        placeholder: 'Confirm Password',
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          } else if (value != passwordController.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              style: TextStyle(color: FluentTheme.of(context).accentColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pop();
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 60),
                      Container(
                        width: double.infinity,
                        child: FilledButton(
                          child: Text('Sign up'),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              // sign up
                              final res = await context.read<AuthProvider>().signUpWithEmailAndPassword(
                                emailController.text,
                                passwordController.text,
                              );
                              if (res) {
                                context.push('/otp/${Uri.encodeComponent(emailController.text)}');
                              }
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
        ]),
      ),
    );
  }
}

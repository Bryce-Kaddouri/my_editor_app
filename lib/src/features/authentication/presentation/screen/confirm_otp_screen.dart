import 'package:fluent_ui/fluent_ui.dart' hide Card;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' show Card;
import 'package:my_editor_app/src/features/authentication/data/datasource/auth_datasource.dart';
import 'package:pinput/pinput.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConfirmOtpScreen extends StatelessWidget {
  const ConfirmOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldPage(
        content: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the OTP sent to your email',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: FilledRoundedPinPut(
                  controller: TextEditingController(),
                  onChanged: (value) {
                    print(value);
                  },
                  onCompleted: (value) async {
                    print(value);
                    final res = await AuthenticationDataSource()
                        .confirmEmailWithOTP('bryce.kaddouri.dublin@gmail.com', value, OtpType.email);

                    res.fold(
                      (l) {
                        print(l);
                      },
                      (r) {
                        print(r);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Didn\'t receive the OTP? ',
                  children: [
                    TextSpan(
                      text: 'Resend OTP',
                      style: TextStyle(color: FluentTheme.of(context).accentColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Resend OTP tapped");
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {},
                child: const Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilledRoundedPinPut extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;
  const FilledRoundedPinPut({super.key, required this.controller, required this.onChanged, required this.onCompleted});

  @override
  _FilledRoundedPinPutState createState() => _FilledRoundedPinPutState();

  @override
  String toStringShort() => 'Rounded Filled';
}

class _FilledRoundedPinPutState extends State<FilledRoundedPinPut> {
  /* final controller = TextEditingController();*/
  final focusNode = FocusNode();

  @override
  void dispose() {
    widget.controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: FluentTheme.of(context).typography!.body!.copyWith(
            fontSize: 22,
            color: const Color.fromRGBO(30, 60, 87, 1),
          ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 68,
      child: Pinput(
        length: length,
        controller: widget.controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        onCompleted: (pin) {
          /*setState(() => showError = pin != '5555');*/

          widget.onCompleted(pin);
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 68,
          width: 64,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

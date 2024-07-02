import 'package:supabase_flutter/supabase_flutter.dart';


class ConfirmEmailParam {
  final String email;
  final String otp;
  final OtpType otpType;

  ConfirmEmailParam({required this.email, required this.otp, required this.otpType});
}

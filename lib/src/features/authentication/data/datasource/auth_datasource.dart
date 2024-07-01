import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/data/exception/failure.dart';

class AuthenticationDataSource {
  final _client = Supabase.instance.client;

  // method to sign up with email and password
  Future<Either<Failure, bool>> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _client.auth.signInWithOtp(email: email, shouldCreateUser: true);

      return Right(true);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(errorMessage: e.message, errorCode: e.code));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString(), errorCode: null));
    }
  }

  // method to sign in with email and password
  Future<Either<Failure, bool>> signInWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _client.auth.signInWithOtp(email: email, shouldCreateUser: false);
      return Right(true);
    } on PostgrestException catch (e) {
      print(e.message);
      return Left(ServerFailure(errorMessage: e.message, errorCode: e.code));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString(), errorCode: null));
    }
  }

  // method to confirm email with OTP
  Future<Either<Failure, User>> confirmEmailWithOTP(String email, String otp, OtpType otpType) async {
    try {
      final response = await _client.auth.verifyOTP(email: email, token: otp, type: otpType);
      return Right(response.user!);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(errorMessage: e.message, errorCode: e.code));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString(), errorCode: null));
    }
  }
}

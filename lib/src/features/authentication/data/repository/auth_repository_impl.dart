import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/authentication/business/param/confirm_email_param.dart';
import 'package:my_editor_app/src/features/authentication/business/param/sign_in_param.dart';
import 'package:my_editor_app/src/features/authentication/business/param/sign_up_param.dart';
import 'package:my_editor_app/src/features/authentication/business/repository/auth_repository.dart';
import 'package:my_editor_app/src/features/authentication/data/datasource/auth_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthenticationDataSource _authDatasource = AuthenticationDataSource();

  @override
  Future<Either<Failure, User>> confirmEmailWithOTP(ConfirmEmailParam confirmEmailParam) async {
    return await _authDatasource.confirmEmailWithOTP(confirmEmailParam.email, confirmEmailParam.otp, confirmEmailParam.otpType);
  }

  @override
  Future<Either<Failure, User>> getUser(EmptyParams param) async {
    return await _authDatasource.getUser();
  }

  @override
  Stream<AuthState> listenOnAuthStateChange(EmptyParams param) {
    return _authDatasource.listenOnAuthStateChange();
  }

  @override
  Future<Either<Failure, bool>> signInWithEmailAndPassword(SignInParam signInParam) async {
    return await _authDatasource.signInWithEmailAndPassword(signInParam.email, signInParam.password);
  }

  @override
  Future<Either<Failure, bool>> signOut(EmptyParams param) async {
    return await _authDatasource.signOut();
  }

  @override
  Future<Either<Failure, bool>> signUpWithEmailAndPassword(SignUpParam signUpParam) async {
    return await _authDatasource.signUpWithEmailAndPassword(signUpParam.email, signUpParam.password);
  }

  
}
import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/authentication/business/param/sign_in_param.dart';
import 'package:my_editor_app/src/features/authentication/business/param/sign_up_param.dart';
import 'package:my_editor_app/src/features/authentication/business/param/confirm_email_param.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> signUpWithEmailAndPassword(SignUpParam signUpParam);
  Future<Either<Failure, bool>> signInWithEmailAndPassword(SignInParam signInParam);
  Future<Either<Failure, User>> confirmEmailWithOTP(ConfirmEmailParam confirmEmailParam);
  Future<Either<Failure, bool>> signOut(NoParams params);
  Future<Either<Failure, User>> getUser(NoParams params);
  Stream<AuthState> listenOnAuthStateChange(NoParams params);
}

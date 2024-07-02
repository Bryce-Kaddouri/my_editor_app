import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/authentication/business/param/confirm_email_param.dart';
import 'package:my_editor_app/src/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConfirmEmailWithOtpUseCase implements SingleUseCaseAsync<Either<Failure, User>, ConfirmEmailParam> {
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

  @override
  Future<Either<Failure, User>> call(ConfirmEmailParam params) {
    return _authRepository.confirmEmailWithOTP(params);
  }
}
import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetUserUseCase implements SingleUseCaseAsync<Either<Failure, User>, NoParams> {
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return _authRepository.getUser(params);
  }
}

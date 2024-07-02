
import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/authentication/data/repository/auth_repository_impl.dart';


class SignOutUseCase implements SingleUseCaseAsync<Either<Failure, bool>, NoParams> {
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

 @override
  Future<Either<Failure, bool>> call(NoParams params) async{
    return _authRepository.signOut(params);
  }
}

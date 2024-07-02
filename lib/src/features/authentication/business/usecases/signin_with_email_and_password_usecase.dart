import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/authentication/business/param/sign_in_param.dart';
import 'package:my_editor_app/src/features/authentication/data/repository/auth_repository_impl.dart';


import '../repository/auth_repository.dart';

class SignInWithEmailAndPasswordUseCase implements SingleUseCaseAsync<Either<Failure, bool>, SignInParam> {
  final AuthRepository _authRepository = AuthRepositoryImpl();

 

  @override
  Future<Either<Failure, bool>> call(SignInParam params) async{
    return _authRepository.signInWithEmailAndPassword(params);
  }
}
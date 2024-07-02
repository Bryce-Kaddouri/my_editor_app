import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListenOnAuthStateChangeUseCase implements StreamUseCase<AuthState, NoParams> {
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

  @override
  Stream<AuthState> call(NoParams params) {
    return _authRepository.listenOnAuthStateChange(params);
  }
}

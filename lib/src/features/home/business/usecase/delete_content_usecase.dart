import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/home/data/repository/content_repository_impl.dart';

class DeleteContentUseCase implements SingleUseCaseAsync<Either<Failure, bool>, int> {
  final ContentRepositoryImpl _contentRepository = ContentRepositoryImpl();

  @override
  Future<Either<Failure, bool>> call(int id) {
    return _contentRepository.deleteContent(id);
  }
}

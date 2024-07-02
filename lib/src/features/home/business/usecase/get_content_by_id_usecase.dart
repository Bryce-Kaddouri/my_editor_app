import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/home/data/model/content_model.dart';
import 'package:my_editor_app/src/features/home/data/repository/content_repository_impl.dart';

class GetContentByIdUseCase implements SingleUseCaseAsync<Either<Failure, ContentModel>, int> {
  final ContentRepositoryImpl _contentRepository = ContentRepositoryImpl();

  @override
  Future<Either<Failure, ContentModel>> call(int id) {
    return _contentRepository.getContentById(id);
  }
}

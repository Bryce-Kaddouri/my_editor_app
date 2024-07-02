import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/home/data/model/content_model.dart';
import 'package:my_editor_app/src/features/home/data/repository/content_repository_impl.dart';

class ListAllContentUseCase implements SingleUseCaseAsync<Either<Failure, List<ContentModel>>, NoParams> {
  final ContentRepositoryImpl _contentRepository = ContentRepositoryImpl();

  @override
  Future<Either<Failure, List<ContentModel>>> call(NoParams params) {
    return _contentRepository.listAllContent();
  }
}

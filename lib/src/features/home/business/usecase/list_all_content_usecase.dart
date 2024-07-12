import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/home/business/param/list_contant_param.dart';
import 'package:my_editor_app/src/features/home/data/model/content_model.dart';
import 'package:my_editor_app/src/features/home/data/repository/content_repository_impl.dart';

class ListAllContentUseCase implements SingleUseCaseAsync<Either<Failure, List<ContentModel>>, ListContentParam> {
  final ContentRepositoryImpl _contentRepository = ContentRepositoryImpl();

  @override
  Future<Either<Failure, List<ContentModel>>> call(ListContentParam param) {
    return _contentRepository.listAllContent(param);
  }
}

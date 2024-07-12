import 'package:dartz/dartz.dart';
import 'package:my_editor_app/core/data/exception/failure.dart';
import 'package:my_editor_app/src/features/home/business/param/list_contant_param.dart';
import 'package:my_editor_app/src/features/home/data/model/content_model.dart';

abstract class ContentRepository {
  Future<Either<Failure, ContentModel>> createContent(ContentModel content);
  Future<Either<Failure, ContentModel>> getContentById(int id);
  Future<Either<Failure, ContentModel>> updateContent(ContentModel content);
  Future<Either<Failure, bool>> deleteContent(int id);
  Future<Either<Failure, List<ContentModel>>> listAllContent(ListContentParam param);
}

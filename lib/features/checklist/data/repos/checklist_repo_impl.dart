



import 'package:bodoni/core/error/either.dart';
import 'package:bodoni/core/error/error.dart';
import 'package:bodoni/features/checklist/data/checklist_local_datasource.dart';
import 'package:bodoni/features/checklist/data/models/checklist_model.dart';
import 'package:bodoni/features/checklist/data/repos/checklist_repo.dart';
import 'package:bodoni/features/checklist/domain/entitites/checklist_item.dart';

class ChecklistRepositoryImpl implements ChecklistRepository {
  final ChecklistLocalDataSource localDataSource;

  ChecklistRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<ChecklistItem>>> getChecklist() async {
    try {
      final items = await localDataSource.getChecklist();
      return Right(items);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addChecklistItem(ChecklistItem item) async {
    try {
      final model = ChecklistItemModel(
        id: item.id,
        title: item.title,
        description: item.description,
        isCompleted: item.isCompleted,
        createdAt: item.createdAt,
        completedAt: item.completedAt,
      );
      await localDataSource.addChecklistItem(model);
      return  Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateChecklistItem(ChecklistItem item) async {
    try {
      final model = ChecklistItemModel(
        id: item.id,
        title: item.title,
        description: item.description,
        isCompleted: item.isCompleted,
        createdAt: item.createdAt,
        completedAt: item.completedAt,
      );
      await localDataSource.updateChecklistItem(model);
      return  Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChecklistItem(String id) async {
    try {
      await localDataSource.deleteChecklistItem(id);
      return  Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
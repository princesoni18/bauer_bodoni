
import 'package:bodoni/core/error/either.dart';
import 'package:bodoni/core/error/error.dart';
import 'package:bodoni/features/checklist/domain/entitites/checklist_item.dart';

abstract class ChecklistRepository {
  Future<Either<Failure, List<ChecklistItem>>> getChecklist();
  Future<Either<Failure, void>> addChecklistItem(ChecklistItem item);
  Future<Either<Failure, void>> updateChecklistItem(ChecklistItem item);
  Future<Either<Failure, void>> deleteChecklistItem(String id);
}
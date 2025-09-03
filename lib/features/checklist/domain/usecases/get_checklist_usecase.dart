


import 'package:bodoni/core/error/either.dart';
import 'package:bodoni/core/error/error.dart';
import 'package:bodoni/features/checklist/data/repos/checklist_repo.dart';
import 'package:bodoni/features/checklist/domain/entitites/checklist_item.dart';

class GetChecklistUseCase {
  final ChecklistRepository repository;

  GetChecklistUseCase(this.repository);

  Future<Either<Failure, List<ChecklistItem>>> call() async {
    return await repository.getChecklist();
  }
}
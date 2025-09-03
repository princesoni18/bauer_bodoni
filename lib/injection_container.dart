import 'package:bodoni/features/auth/data/auth_data.dart';
import 'package:bodoni/features/auth/domain/repos/auth_repo.dart';
import 'package:bodoni/features/auth/domain/repos/auth_repo_impl.dart';
import 'package:bodoni/features/auth/domain/usecases/login_usecases.dart';
import 'package:bodoni/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bodoni/features/auth/domain/usecases/register_usecase.dart';
import 'package:bodoni/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bodoni/features/checklist/data/checklist_local_datasource.dart';
import 'package:bodoni/features/checklist/data/repos/checklist_repo.dart';
import 'package:bodoni/features/checklist/data/repos/checklist_repo_impl.dart';
import 'package:bodoni/features/checklist/domain/usecases/get_checklist_usecase.dart';
import 'package:bodoni/features/checklist/presentation/bloc/checklist_bloc.dart';
import 'package:bodoni/features/venues/bloc/venue_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';



final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Auth Feature
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(()=>LogoutUsecase(sl()));
  sl.registerFactory(() => AuthBloc(sl(), sl(),sl()));

  // Checklist Feature
  sl.registerLazySingleton<ChecklistLocalDataSource>(
    () => ChecklistLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ChecklistRepository>(
    () => ChecklistRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetChecklistUseCase(sl()));
  sl.registerFactory(() => ChecklistBloc(sl()));
  sl.registerFactory(() => VenueBloc());

}

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_services.dart';
import '../api/dio_factory.dart';
import '../cubit/theme_cubit.dart';
import '../preferences/app_preferences.dart';
import '../../features/auth/data/datasources/firebase_auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // ── Core ──────────────────────────────────────────────────────────────────
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt()));

  // ── Network ───────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<Dio>(() => DioFactory.createDio());
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt()));
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt()));

  // ── Settings cubits ───────────────────────────────────────────────────────
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt()));

  // ── Auth ──────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSource(FirebaseAuth.instance),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerFactory<LoginUseCase>(() => LoginUseCase(getIt()));
  getIt.registerFactory<SignUpUseCase>(() => SignUpUseCase(getIt()));
  getIt.registerFactory<LogoutUseCase>(() => LogoutUseCase(getIt()));
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt(),
      signUpUseCase: getIt(),
      logoutUseCase: getIt(),
    ),
  );

  // ── Splash ────────────────────────────────────────────────────────────────
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
}

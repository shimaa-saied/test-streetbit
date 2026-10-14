import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../api/api_endpoints.dart';
import '../api/api_services.dart';
import '../api/dio_factory.dart';
import '../preferences/app_preferences.dart';
import '../../features/auth/data/datasources/firebase_auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/home/data/datasources/meal_datasource_factory.dart';
import '../../features/home/data/datasources/meal_local_datasource.dart';
import '../../features/home/data/datasources/meal_remote_datasource.dart';
import '../../features/home/data/repositories/meal_repository_impl.dart';
import '../../features/home/domain/repositories/meal_repository.dart';
import '../../features/home/domain/usecases/get_meals_usecase.dart';
import '../../features/home/presentation/cubit/meals_cubit.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../theming/cubit/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // ── Core ──────────────────────────────────────────────────────────────────
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt()));

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

  // ── Cart ──────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<CartCubit>(() => CartCubit());

  // ── Splash ────────────────────────────────────────────────────────────────
  getIt.registerFactory<SplashCubit>(() => SplashCubit());

  // ── Meals ─────────────────────────────────────────────────────────────────
  // Dedicated ApiServices for TheMealDB (different base URL from StreetBite API).
  getIt.registerLazySingleton<MealRemoteDataSource>(
    () => MealRemoteDataSource(
      ApiServices(DioFactory.createDio(), baseUrl: ApiEndpoints.mealDbBaseUrl),
    ),
  );
  getIt.registerLazySingleton<MealLocalDataSource>(
    () => MealLocalDataSource(getIt()),
  );
  getIt.registerLazySingleton<MealDataSourceFactory>(
    () => MealDataSourceFactory(remote: getIt(), local: getIt()),
  );
  getIt.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(getIt<MealDataSourceFactory>()),
  );
  getIt.registerFactory<GetMealsUseCase>(() => GetMealsUseCase(getIt()));
  getIt.registerLazySingleton<MealsCubit>(() => MealsCubit(getIt()));
}

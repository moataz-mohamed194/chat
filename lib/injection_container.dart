import 'package:chat/features/home/%20domain/usecases/log_out.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'features/auth/ domain/repositories/Login_repositorie.dart';
import 'features/auth/ domain/usecases/create_user.dart';
import 'features/auth/ domain/usecases/login_usecases.dart';
import 'features/auth/ domain/usecases/vilification_phone.dart';
import 'features/auth/data/datasources/login_remote_date_source.dart';
import 'features/auth/data/repositories/login_repositories.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'features/chat/ domain/repositories/Sick_repositorie.dart';
import 'features/chat/ domain/usecases/add _sick.dart';
import 'features/chat/ domain/usecases/get_all_sicks.dart';
import 'features/chat/data/datasources/sick_remote_data_source.dart';
import 'features/chat/data/repositories/sick_repositories.dart';
import 'features/chat/presentation/bloc/add_sick_bloc.dart';
import 'features/home/ domain/repositories/weight_repositorie.dart';
import 'features/home/ domain/usecases/get_all_weight.dart';
import 'features/home/data/datasources/weight_remote_data_source.dart';
import 'features/home/data/repositories/weight_repositories.dart';
import 'features/home/presentation/bloc/add_weight_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //Bloc
  sl.registerFactory(() => LoginBloc(
      loginMethod: sl(),
      createUseMethod: sl(),
      vilificationPhoneUseMethod: sl()));
  sl.registerFactory(
      () => AddUpdateGetWeightBloc(getAllWeight: sl(), logOut: sl()));
  sl.registerFactory(() => AddUpdateGetSickBloc(addSick: sl(), getSick: sl()));

  //UseCase
  sl.registerLazySingleton(() => VilificationPhoneUseCases(sl()));
  sl.registerLazySingleton(() => CreateUseCases(sl()));
  sl.registerLazySingleton(() => LoginUseCases(sl()));
  sl.registerLazySingleton(() => GetAllUseCases(sl()));
  sl.registerLazySingleton(() => LogOutUseCases(sl()));
  sl.registerLazySingleton(() => AddSick(sl()));
  sl.registerLazySingleton(() => GetAllSick(sl()));

  //Repository
  sl.registerLazySingleton<LoginRepositorie>(
      () => LoginRepositoriesImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<SickRepository>(
      () => SickRepositoriesImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<WeightRepository>(
      () => WeightRepositoriesImpl(remoteDataSource: sl(), networkInfo: sl()));

  //Datasources

  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImple());
  sl.registerLazySingleton<WeightRemoteDataSource>(
      () => WeightRemoteDataSourceImple());
  sl.registerLazySingleton<SickRemoteDataSource>(
      () => SickRemoteDataSourceImple());

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

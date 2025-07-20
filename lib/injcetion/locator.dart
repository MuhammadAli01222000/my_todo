import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:my_todo/core/services/auth_service_impl.dart';
import 'package:my_todo/core/services/check_input_data_impl.dart';
import 'package:my_todo/core/services/hive_service_impl.dart';
import 'package:my_todo/domain/interfaces/check_input_data.dart';
import '../core/services/local_notification_services_impl.dart';
import '../core/services/rtdb_service.dart';
import '../core/services/voice_service_impl.dart';
import '../domain/interfaces/cloud.dart';
import '../domain/interfaces/firebase_rtdb.dart';
import '../domain/interfaces/hive_service.dart';
import '../domain/interfaces/local_notification.dart';
import '../domain/interfaces/voice_service.dart';

final GetIt locator = GetIt.instance;
void setUpLocator() {
  locator.registerLazySingleton<Connectivity>(() => Connectivity());
  locator.registerFactory<AuthService>(() => AuthService());
  locator.registerLazySingleton<ITodoService>(() => TodoService());
  locator.registerLazySingleton<ILocalNotificationService>(
    () => LocalNotificationService(),
  );
  locator.registerLazySingleton<VoiceServiceImpl>(() => VoiceServiceImpl());
  locator.registerLazySingleton<FirebaseRealTimeDataBase>(
    () => FirebaseRealTimeDatabaseImpl(),
  );
  locator.registerLazySingleton<CheckInputData>(() => CheckInputDataImpl());
}

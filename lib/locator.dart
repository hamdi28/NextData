
import 'package:get_it/get_it.dart';
import 'package:next_data/core/services/authentication_service.dart';
import 'package:next_data/core/services/connectivity_service.dart';
import 'package:next_data/core/services/http_service.dart';
import 'package:next_data/core/services/local_database_service.dart';
import 'package:next_data/core/services/navigation_service.dart';
import 'package:next_data/core/services/platform_channels_service.dart';
import 'package:next_data/core/services/shared_preferences_service.dart';
import 'package:next_data/pages/posts_screen/post_screen_view_model.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator
      .registerSingleton<PlatformChannelsService>(PlatformChannelsService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  locator.registerLazySingleton<AuthService>(()=>AuthService());
  locator.registerLazySingleton<HttpCallsService>(()=>HttpCallsService());
  locator.registerLazySingleton<DatabaseService>(()=>DatabaseService());
  locator.registerLazySingleton<SharedPreferencesService>(()=>SharedPreferencesService());
  locator.registerLazySingleton<PostsScreenViewModel>(()=>PostsScreenViewModel());

}
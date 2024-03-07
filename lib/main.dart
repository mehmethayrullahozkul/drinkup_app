import 'package:drinkup_app/blocs/config/config_bloc.dart';
import 'package:drinkup_app/blocs/network/network_bloc.dart';
import 'package:drinkup_app/blocs/user/user.dart';
import 'package:drinkup_app/repositories/data/data_repository.dart';
import 'package:drinkup_app/services/config/config_service.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth.dart';
import 'package:go_router/go_router.dart';
import 'package:drinkup_app/services/water_data/water_data_service.dart';
import 'models/router/router_model.dart';
import 'package:flutter/gestures.dart';
import 'package:drinkup_app/blocs/water_progress/water_progress.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:drinkup_app/constants/constants.dart';
import 'package:flutter/services.dart';
import 'package:drinkup_app/models/config/config_model.dart';
import 'package:go_router/go_router.dart';
import 'repositories/user/user_repository.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:drinkup_app/repositories/config/config_repository.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  developerLog("SUCCESS: WidgetsBinding initialized");
  GestureBinding.instance.resamplingEnabled = true;

  /* FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); */
  final ConfigRepository configRepository = await ConfigRepository.init();
  developerLog("SUCCESS: ConfigRepository initialized");
  final DataRepository dataRepository = await DataRepository.init();
  developerLog("SUCCESS: DataRepository initialized");
  final UserRepository userRepistory = UserRepository();
  developerLog("SUCCESS: UserRepository created");
  /*  await Hive.initFlutter(ConfigRepository.appDataDir);
  await Hive.deleteBoxFromDisk("latest-units",
      path: ConfigRepository.appDataDir);
  await Hive.deleteBoxFromDisk("latest-data",
      path: ConfigRepository.appDataDir);
  await Hive.deleteBoxFromDisk("data-logs", path: ConfigRepository.appDataDir);

  return; */

  ConfigService configService =
      ConfigService(configRepository: configRepository);
  developerLog("SUCCESS: ConfigService created");
  AuthenticationBloc authBloc =
      AuthenticationBloc(userRepository: userRepistory)
        ..add(AuthenticationStart());

  developerLog("SUCCESS: AuthenticationBloc created");

  final WaterDataService waterDataService =
      WaterDataService(dataRepository: dataRepository);

  Bloc.observer = SimpleBlocObserver();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => dataRepository),
        RepositoryProvider(create: (context) => waterDataService),
        RepositoryProvider(create: (context) => userRepistory),
        /* RepositoryProvider(create: (context) => config) */
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<ConfigBloc>(
            create: (BuildContext context) =>
                ConfigBloc(configService: configService)..add(ConfigStarted())),
        BlocProvider<UserBloc>(
            create: (BuildContext context) =>
                UserBloc(userRepository: userRepistory)),
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => authBloc),
        BlocProvider<WaterProgressBloc>(
          create: (context) =>
              WaterProgressBloc(waterDataService: waterDataService)
                ..add(WaterProgressStarted()),
        ),
        BlocProvider<NetworkBloc>(
            create: (BuildContext context) => NetworkBloc())
      ], child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    developerLog("STATUS: MyApp build started");

    final GoRouter myRouter = AppRouter.initRouter(context);
    developerLog("SUCCESS: GoRouter initialized");

    return LayoutBuilder(builder: (context, constraints) {
      SizeService().load(
          logicalWidth: MediaQuery.of(context).size.width,
          logicalHeight: MediaQuery.of(context).size.height);
      developerLog("SUCCESS: SizeService loaded");
      return AuthStreamScope(
        authBloc: BlocProvider.of<AuthenticationBloc>(context),
        child: MaterialApp.router(

            /* checkerboardRasterCacheImages: true, */
            /* checkerboardOffscreenLayers: true, */
            /* showPerformanceOverlay: true, */
            debugShowCheckedModeBanner: false,
            routerConfig: myRouter),
      );
    });
  }
}

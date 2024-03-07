import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  static final NetworkBloc _instance = NetworkBloc._();
  factory NetworkBloc() => _instance;

  StreamSubscription? _network_listener_subscription;
  var hasInternetAccess = false;

  NetworkBloc._() : super(const NetworkState.unknown()) {
    on<NetworkStatusChange>(_onNetworkStatusChanged);

    _network_listener_subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      print("Checking connectivity.");
      if (result != ConnectivityResult.none) {
        print("Connectivity : found");
        hasInternetAccess = await InternetConnectionChecker().hasConnection;
        if (hasInternetAccess) {
          print("Internet access: found");
          NetworkBloc().add(const NetworkStatusChange(isConnected: true));
        } else {
          NetworkBloc().add(const NetworkStatusChange(isConnected: false));
        }
      } else {
        NetworkBloc().add(const NetworkStatusChange(isConnected: false));
      }
    });
  }

  @override
  Future<void> close() {
    _network_listener_subscription!.cancel();
    print("Substricition cancelled.");
    return super.close();
  }

  Future<bool> hasInternet() async {
    hasInternetAccess = false;
    hasInternetAccess = await InternetConnectionChecker().hasConnection;
    NetworkBloc().add(NetworkStatusChange(isConnected: hasInternetAccess));
    return hasInternetAccess;
  }
}

Future<void> _onNetworkStatusChanged(
  NetworkStatusChange event,
  Emitter<NetworkState> emit,
) async {
  switch (event.isConnected) {
    case true:
      return emit(const NetworkState.connected());
    case false:
      return emit(const NetworkState.disconnected());
  }
}

part of 'network_bloc.dart';

//sealed class NetworkState extends Equatable {
//  const NetworkState();
//
//  @override
//  List<Object> get props => [];
//}
//
//final class NetworkInitial extends NetworkState {}
//
//final class NetworkHasConnection extends NetworkState {}
//
//final class NetworkDisconnected extends NetworkState {}

class NetworkState extends Equatable {
  //const NetworkState({this.isConnected = false});
  const NetworkState._({this.isConnected = false});
  const NetworkState.unknown() : this._();
  const NetworkState.connected() : this._(isConnected: true);
  const NetworkState.disconnected() : this._(isConnected: false);
  final bool isConnected;
  @override
  List<Object> get props => [isConnected];
}

/* class NetworkConnected extends NetworkState {}

final class NetworkDisconnected extends NetworkState {} */

part of 'network_bloc.dart';

sealed class NetworkEvent {
  const NetworkEvent();
}

class NetworkStatusChange extends NetworkEvent {
  const NetworkStatusChange({required this.isConnected});

  final bool isConnected;
}

final class NetworkObserve extends NetworkEvent {}

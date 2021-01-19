import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'bloc.dart';
import '../events/connectivity_status.dart';

class ConnectivityServiceBloc extends Bloc {
  StreamController<ConnectivityStatus> connectionStatusController = StreamController<ConnectivityStatus>.broadcast();

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Online;
      case ConnectivityResult.none:
      default:
        return ConnectivityStatus.Offline;
    }
  }

  @override
  void dispose() {
    connectionStatusController.close();
  }

  @override
  void initialize() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      var connectionStatus = _getStatusFromResult(result);
      connectionStatusController.add(connectionStatus);
    });
  }
}

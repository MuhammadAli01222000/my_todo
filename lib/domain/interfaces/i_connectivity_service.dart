import 'package:connectivity_plus/connectivity_plus.dart';

abstract class IConnectivityService {
  Future<bool> isConnected();
  Stream<List<ConnectivityResult>> onConnectChange();
}

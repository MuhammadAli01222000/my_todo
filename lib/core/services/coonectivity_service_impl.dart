import 'package:connectivity_plus/connectivity_plus.dart';
import '../../domain/interfaces/i_connectivity_service.dart';

class ConnectivityService implements IConnectivityService {
  final Connectivity _connectivity = Connectivity();

  @override
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result.isNotEmpty && result.first != ConnectivityResult.none;
  }

  @override
  Stream<List<ConnectivityResult>> onConnectChange() {
    return _connectivity.onConnectivityChanged;
  }
}

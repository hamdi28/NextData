import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final StreamController<bool> _streamController = StreamController<bool>.broadcast();

  Stream<bool> get connectivityStream => _streamController.stream;
  late StreamSubscription _networkSubscription;

  bool get isConnected => _isConnected;
  bool _isConnected = true;

  ///checks the availability of internet connection
  void initCheckConnectivity() {
    _checkInternetAccess();
    _networkSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none && _isConnected == true) {
        _isConnected = false;
        _streamController.sink.add(_isConnected);
        // _dialogService.showNoConnexionDialog();
      } else if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        _checkInternetAccess();
      }
    });
  }

  /// ping google website to check internet
  void _checkInternetAccess() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
        _streamController.sink.add(_isConnected);
      }
    } on SocketException catch (_) {
      _isConnected = false;
      // _dialogService.showNoConnexionDialog();
      _streamController.sink.add(_isConnected);
    }
  }

  void dispose() {
    _networkSubscription.cancel();
  }
}

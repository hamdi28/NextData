import 'package:next_data/core/services/connectivity_service.dart';
import 'package:next_data/core/services/navigation_service.dart';
import 'package:next_data/locator.dart';
import 'package:stacked/stacked.dart';

/// ViewModel for managing the state of the Home screen.
///
/// This class extends [IndexTrackingViewModel] and provides functionality
/// for tracking the currently selected index and checking connectivity.
class HomeScreenViewModel extends IndexTrackingViewModel {
  /// Instance of [ConnectivityService] used to check network connectivity.
  final ConnectivityService _connectivityService =
  locator<ConnectivityService>();

  /// The index of the currently selected item on the Home screen.
  int _currentIndex = 1;

  /// Getter for the current index.
  int get currentIndex => _currentIndex;

  /// Initializes the ViewModel by checking connectivity status.
  ///
  /// This method should be called when the ViewModel is initialized
  /// to ensure that the network connectivity is checked.
  void init() {
    _connectivityService.initCheckConnectivity();
  }

  /// Updates the current index and notifies listeners of the change.
  ///
  /// [value] is the new index to be set.
  void setIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}

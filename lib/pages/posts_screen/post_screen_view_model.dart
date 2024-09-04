import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:next_data/core/config/app_config.dart';
import 'package:next_data/core/config/enums.dart';
import 'package:next_data/core/config/routing_constants.dart';
import 'package:next_data/core/config/utils.dart';
import 'package:next_data/core/models/generic_model.dart';
import 'package:next_data/core/models/post_model.dart';
import 'package:next_data/core/models/user_model.dart';
import 'package:next_data/core/services/connectivity_service.dart';
import 'package:next_data/core/services/http_service.dart';
import 'package:next_data/core/services/local_database_service.dart';
import 'package:next_data/core/services/navigation_service.dart';
import 'package:next_data/core/services/shared_preferences_service.dart';
import 'package:next_data/locator.dart';
import 'package:next_data/pages/shared_widget/debouncer_widget.dart';
import 'package:next_data/pages/shared_widget/post_search.dart';
import 'package:stacked/stacked.dart';

/// ViewModel for managing the state of the Posts screen.
///
/// This class extends [BaseViewModel] and handles fetching and displaying
/// posts and users, managing connectivity, and handling search functionality.
class PostsScreenViewModel extends BaseViewModel {
  /// Instance of [HttpCallsService] used for making HTTP requests.
  final HttpCallsService _httpCallsService = locator<HttpCallsService>();

  /// Instance of [NavigationService] used for navigating between screens.
  final NavigationService _navigationService = locator<NavigationService>();

  /// Instance of [DatabaseService] used for local database operations.
  final DatabaseService _databaseService = locator<DatabaseService>();

  /// Instance of [ConnectivityService] used for managing connectivity status.
  final ConnectivityService _connectivityService =
  locator<ConnectivityService>();

  /// Instance of [SharedPreferencesService] used for managing shared preferences.
  final SharedPreferencesService _sharedPreferencesService =
  locator<SharedPreferencesService>();

  /// List of posts to be displayed on the screen.
  List<Post> _posts = List<Post>.empty(growable: true);

  /// Getter for the list of posts.
  List<Post> get posts => _posts;

  /// List of users to be displayed or used in the view model.
  List<User> _users = List<User>.empty(growable: true);

  /// Getter for the list of users.
  List<User> get users => _users;

  /// List of generic data, used for various purposes.
  List<GenericModel> _genericData = List<GenericModel>.empty(growable: true);

  /// Getter for the list of generic data.
  List<GenericModel> get genericData => _genericData;

  /// Random number generator for various purposes.
  final Random _random = Random();

  /// Getter for a random number between 0 and 10.
  int get randomNumber => _random.nextInt(10);

  /// The date of the last cache update.
  String? lastCacheUpdateDate;

  /// Flag to determine whether to display an error screen.
  bool _displayErrorScreen = false;

  /// Getter for the error screen display flag.
  bool get displayErrorScreen => _displayErrorScreen;

  /// Subscription to the connectivity stream.
  StreamSubscription? _connectionStreamSubscription;

  /// Controller for the search text field.
  final TextEditingController _searchEditingController =
  TextEditingController();

  /// Getter for the search field controller.
  TextEditingController get searchEditingController => _searchEditingController;

  /// Instance of [PostSearch] used for managing search functionality.
  late PostSearch postSearch;

  /// List of search results.
  List<Post> _searchResults = List<Post>.empty(growable: true);

  /// Getter for the list of search results.
  List<Post> get searchResults => _searchResults;

  /// Flag to determine whether the user is currently searching.
  bool _isUserSearching = false;

  /// Getter for the user searching flag.
  bool get isUserSearching => _isUserSearching;

  /// Initializes the ViewModel and handles initial data fetching and setup.
  void init() {
    _connectionStreamSubscription =
        _connectivityService.connectivityStream.listen(handleConnectivity);
    setBusy(true);
    lastCacheUpdateDate =
        _sharedPreferencesService.getFromDisk(lastCacheUpdate);
    if (lastCacheUpdateDate != null && _connectivityService.isConnected) {
      getDataFromLocalStorage();
    } else if (lastCacheUpdateDate == null &&
        !_connectivityService.isConnected) {
      _displayErrorScreen = true;
      setBusy(false);
      notifyListeners();
    } else {
      fetchAllPostsTask();
    }
    notifyListeners();
  }

  /// Saves the current posts to local storage if they are not already present.
  Future<void> putDataToLocalStorageIfAppent() async {
    for (var element in _posts) {
      await _databaseService.insertRecord(GenericModel(
          userId: element.userId,
          postId: element.id,
          postTitle: element.title,
          userName: getUserByID(element.userId).name,
          postBody: element.body)
          .toJson());
    }
  }

  /// Fetches all posts from the server and updates the ViewModel's state.
  void fetchAllPostsTask() {
    Task(() => _httpCallsService.request<Post>(
        method: HttpRequestMethod.get,
        url: postsApiUrlName,
        fromJson: Post.fromJson))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((eitherResult) => eitherResult.fold(
            (failure) => {
          _displayErrorScreen = true,
          notifyListeners(),
          setBusy(false),
        },
            (posts) => {
          _posts = posts,
          if (_posts.isEmpty)
            {
              setBusy(false),
              _displayErrorScreen = true,
              notifyListeners(),
            }
          else
            {
              postSearch = PostSearch(
                posts: _posts,
                debouncer: Debouncer(milliseconds: 300),
              ),
              fetchAllUsersTask(),
            }
        }));
  }

  /// Fetches all users from the server and updates the ViewModel's state.
  void fetchAllUsersTask() {
    Task(() => _httpCallsService.request<User>(
        method: HttpRequestMethod.get,
        url: usersApiUrlName,
        fromJson: User.fromJson))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((eitherResult) => eitherResult.fold(
            (failure) => {
          _displayErrorScreen = true,
          notifyListeners(),
          setBusy(false),
        },
            (users) => {
          _users = users,
          if (_users.isNotEmpty)
            {
              setBusy(false),
              notifyListeners(),
              if (lastCacheUpdateDate == null)
                {
                  addDataToLocalStorage(),
                }
            }
          else
            {
              setBusy(false),
              _displayErrorScreen = true,
              notifyListeners(),
            }
        }));
  }

  /// Adds the current data to local storage and updates the cache date.
  void addDataToLocalStorage() {
    Task(() => putDataToLocalStorageIfAppent())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((eitherResult) => eitherResult.fold(
            (failure) => {
          setBusy(false),
        },
            (_) => {
          _sharedPreferencesService.saveModelToDisk(
              lastCacheUpdate, DateTime.now().toString()),
        }));
  }

  /// Retrieves data from local storage and updates the ViewModel's state.
  void getDataFromLocalStorage() {
    Task(() => _databaseService.getRecords())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((eitherResult) => eitherResult.fold(
            (failure) => {},
            (result) => {
          (result as List<dynamic>)
              .map((e) => e as Map<dynamic, dynamic>)
              .toList()
              .forEach((element) {
            _genericData.add(GenericModel.fromJson(element));
          }),
        }));
  }

  /// Retrieves a user by their ID from the list of users.
  ///
  /// [userId] The ID of the user to retrieve.
  /// Returns the [User] object corresponding to the given ID.
  User getUserByID(int userId) {
    return _users.firstWhere((element) => element.id == userId);
  }

  /// Handles the action of tapping on a post detail.
  ///
  /// [index] The index of the post in the list to navigate to.
  void onTapDetails(int index) {
    _navigationService.navigateTo(
      singlePostScreenRouteName,
      arguments: {
        "post": _posts[index],
        "user": getUserByID(_posts[index].userId),
      },
    );
  }

  /// Handles changes in connectivity status.
  ///
  /// [isConnected] A boolean indicating whether the device is connected to the internet.
  void handleConnectivity(bool isConnected) {
    if (_posts.isEmpty) {
      _displayErrorScreen = false;
      notifyListeners();
      setBusy(true);
      fetchAllPostsTask();
    }
  }

  /// Handles changes in the search value and updates the search results.
  ///
  /// [value] The current search value entered by the user.
  void onSearchValueChanges(String value) {
    if(value.isEmpty){
      _searchResults.clear();
      _isUserSearching = false;
      notifyListeners();
      return;
    }
    _isUserSearching = true;
    postSearch.search(value, (results) {
      if(results.length != _searchResults.length){
        _searchResults.clear();
      }
      for (var post in results) {
        if(!_searchResults.contains(post)){
          _searchResults.add(post);
        }
      }
      notifyListeners();
    });
  }

  /// Converts a [Post] object to a [GenericModel] object.
  ///
  /// [post] The [Post] object to convert.
  /// Returns a [GenericModel] object containing the post and user data.
  GenericModel castDataToGenericModel(Post post) {
    User _user = getUserByID(post.userId);
    return GenericModel(
      userId: _user.id,
      postId: post.id,
      postTitle: post.title,
      userName: _user.name,
      postBody: post.body,
    );
  }

  /// Disposes of resources when the ViewModel is no longer needed.
  @override
  void dispose() {
    if (_connectionStreamSubscription != null) {
      _connectionStreamSubscription!.cancel();
    }
    super.dispose();
  }
}

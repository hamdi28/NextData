/// Enum representing the different HTTP request methods.
///
/// This enum is used to specify the type of HTTP request being made.
enum HttpRequestMethod { get, post }

/// Enum representing the different items in the home screen navigation.
///
/// This enum includes the various sections a user can navigate to within the home screen.
enum HomeItems {
  Home,
  Posts,
  Explore,
  Account;

  /// Factory constructor to create a [HomeItems] enum from an integer index.
  ///
  /// [index] should be the position of the enum value in the list of values.
  /// Returns the [HomeItems] enum corresponding to the provided [index].
  factory HomeItems.fromInt(int index) => values[index];
}

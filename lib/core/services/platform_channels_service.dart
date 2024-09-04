import 'package:flutter/services.dart';

/// A service that facilitates communication between Flutter and native platform code
/// using platform channels. It provides a method to invoke a specific method on
/// a given channel and handle any potential exceptions.
class PlatformChannelsService {

  /// Invokes a method on the specified platform channel.
  ///
  /// The [channelName] parameter specifies the platform channel to use.
  /// The [methodName] parameter specifies the method to invoke on the platform side.
  /// Optionally, [arguments] can be provided to pass data to the method.
  ///
  /// Returns the result of the method invocation, or `null` if an error occurs.
  Future<dynamic> invokeMethod(String channelName, String methodName, {Map<String, dynamic>? arguments}) async {
    final MethodChannel channel = MethodChannel(channelName);
    try {
      final result = await channel.invokeMethod(methodName, arguments);
      return result;
    } on PlatformException catch (e) {
      print("Failed to invoke method '$methodName' on channel '$channelName': ${e.message} , stackTrace : ${e.details}");
      return null;
    }
  }
}

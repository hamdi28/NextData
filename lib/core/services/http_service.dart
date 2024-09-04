import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:next_data/core/config/enums.dart';
import 'package:next_data/core/models/post_model.dart';

/// A service that handles HTTP requests and returns a list of objects of type [T].
class HttpCallsService {
  /// Sends an HTTP request based on the provided [method], [url], and optional [body] and [headers].
  ///
  /// The [method] parameter defines the HTTP method to use, such as GET or POST.
  /// The [url] parameter specifies the endpoint to send the request to.
  /// The [body] parameter contains the data to be sent in the request (only applicable for POST requests).
  /// The [headers] parameter allows customization of the request headers.
  /// The [fromJson] function is used to convert the JSON response into an object of type [T].
  ///
  /// Returns a list of objects of type [T] if the request is successful.
  /// In case of failure, returns an empty list.
  Future<List<T>> request<T>({
    required HttpRequestMethod method,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    // Parse the URL and set default headers if none are provided.
    final uri = Uri.parse(url);
    final requestHeaders = headers ?? {'Content-Type': 'application/json'};
    List<T> fetchResult = List<T>.empty(growable: true);

    try {
      http.Response response;

      // Execute the HTTP request based on the method provided.
      switch (method) {
        case HttpRequestMethod.get:
          response = await http.get(uri, headers: requestHeaders);
          break;
        case HttpRequestMethod.post:
          response = await http.post(uri, headers: requestHeaders, body: jsonEncode(body));
          break;
        default:
          throw Exception('Invalid HTTP method');
      }

      // Check if the response status code indicates success.
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Decode the response body and convert each element to type [T].
        final responseBody = jsonDecode(response.body) as List<dynamic>;
        responseBody.forEach((element) {
          fetchResult.add(fromJson(element));
        });
        return fetchResult;
      } else {
        // Log the error if the status code indicates failure.
        print('HTTP request failed with status: ${response.statusCode}. Response body: ${response.body}');
        return fetchResult;
      }
    } catch (e) {
      // Catch and log any errors that occur during the request.
      print('HTTP request error: $e');
      return fetchResult;
    }
  }
}

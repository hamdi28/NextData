import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:next_data/core/config/app_config.dart';
import 'package:next_data/core/models/generic_model.dart';
import 'package:next_data/core/services/platform_channels_service.dart';
import 'package:next_data/locator.dart';

/// A service that handles database operations such as inserting, retrieving,
/// and deleting records using platform channels to communicate with native code.
class DatabaseService {
  /// Instance of [PlatformChannelsService] used to invoke platform-specific database methods.
  final PlatformChannelsService _platformChannelService =
  locator<PlatformChannelsService>();

  /// Inserts a record into the database.
  ///
  /// The [args] parameter contains the data to be inserted.
  /// If the insertion fails, an error message is printed to the console.
  Future<void> insertRecord(Map<String, dynamic> args) async {
    try {
      await _platformChannelService.invokeMethod(
          databaseChannelName, whriteToTheDatabase,
          arguments: args);
    } on PlatformException catch (e) {
      print("Failed to insert record: '${e.message}'.");
    }
  }

  /// Retrieves records from the database.
  ///
  /// Returns a list of records if the retrieval is successful.
  /// If the retrieval fails, an error message is printed and an empty list is returned.
  Future<List<dynamic>> getRecords() async {
    try {
      final dynamic records = await _platformChannelService.invokeMethod(
        databaseChannelName,
        getFromTheDatabase,
      );
      return records;
    } on PlatformException catch (e) {
      print("Failed to get records: '${e.message}'.");
      return [];
    }
  }

  /// Deletes a record from the database.
  ///
  /// The [tableName] parameter specifies the table from which to delete the record.
  /// The [id] parameter specifies the ID of the record to delete.
  /// If the deletion fails, an error message is printed to the console.
  Future<void> deleteRecord(String tableName, int id) async {
    try {
      Map<String, dynamic> arguments = {
        DatabasePropertiesKeys.table: tableName,
        DatabasePropertiesKeys.id: id,
      };

      await _platformChannelService.invokeMethod(
          databaseChannelName, deleteFromTheDatabase,
          arguments: arguments);
    } on PlatformException catch (e) {
      print("Failed to delete record: '${e.message}'.");
    }
  }
}

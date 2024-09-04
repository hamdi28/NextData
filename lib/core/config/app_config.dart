
//Platform channels names
import 'package:flutter/material.dart';

const String authChannelName = "com.firebase.auth";
const String databaseChannelName = "com.local.database";
const String signInWithEmailAndPassword = "sign_in_with_email_and_password";
const String signUPWithEmailAndPassword = "sign_up_with_email_and_password";
const String whriteToTheDatabase = "insertPost";
const String getFromTheDatabase = "getPosts";
const String deleteFromTheDatabase = "deleteRecord";

///Api's Url
const String postsApiUrlName = "https://jsonplaceholder.typicode.com/posts";
const String usersApiUrlName = "https://jsonplaceholder.typicode.com/users";

///shared Preferences
const String lastCacheUpdate = "LastCacheUpdate";

///Authentication properties keys
class AuthPropertiesKeys {
  static const String email = 'email';
  static const String password = 'password';
}
///Authentication properties keys
class DatabasePropertiesKeys {
  static const String table = 'table';
  static const String record = 'record';
  static const String id = 'id';
}

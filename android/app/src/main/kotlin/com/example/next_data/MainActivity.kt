package com.example.next_data

import android.annotation.SuppressLint
import android.content.ContentValues
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val AUTH_CHANNEL = "com.firebase.auth"
    private lateinit var nativeAuth: NativeAuth

    private val DB_CHANNEL = "com.local.database"
    private lateinit var databaseHelper: DatabaseHelper

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Initialize NativeAuth and DatabaseHelper
        nativeAuth = NativeAuth(MethodChannel(flutterEngine.dartExecutor.binaryMessenger, AUTH_CHANNEL))
        databaseHelper = DatabaseHelper(this)

        // Set up MethodChannel for Authentication
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, AUTH_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "sign_in_with_email_and_password" -> {
                        val email = call.argument<String>("email")
                        val password = call.argument<String>("password")
                        if (email != null && password != null) {
                            nativeAuth.signInWithEmailPassword(email, password, result)
                        } else {
                            result.error("INVALID_ARGUMENT", "Email or Password is null", null)
                        }
                    }
                    "sign_up_with_email_and_password" -> {
                        val email = call.argument<String>("email")
                        val password = call.argument<String>("password")
                        if (email != null && password != null) {
                            nativeAuth.signUpWithEmailPassword(email, password, result)
                        } else {
                            result.error("INVALID_ARGUMENT", "Email or Password is null", null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }

        // Set up MethodChannel for Database
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DB_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "insertPost" -> {
                        val title = call.argument<String>("postTitle")
                        val body = call.argument<String>("postBody")
                        val userName = call.argument<String>("userName")
                        val userId = call.argument<Int>("userId")
                        if (title != null && body != null  && userName != null && userId != null) {
                            insertPost(title, body, userName, userId)
                            result.success("Post inserted")
                        } else {
                            result.error("INVALID_ARGUMENT", "Title or Body is null", null)
                        }
                    }
                    "getPosts" -> {
                        val posts = getPosts()
                        result.success(posts)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun insertPost(title: String, body: String, userName: String, userId: Int) {
        val db = databaseHelper.writableDatabase
        val values = ContentValues().apply {
            put("postTitle", title)
            put("postBody", body)
            put("userName", userName)
            put("userId", userId)
        }
        db.insert("posts", null, values)
        db.close()
    }

    @SuppressLint("Range")
    private fun getPosts(): ArrayList<Map<String, Any>> {

        val db = databaseHelper.readableDatabase
        val cursor = db.query("posts", null, null, null, null, null, null)
        val result = ArrayList<Map<String, Any>>()
        while (cursor.moveToNext()) {
            // Create a new map for each row
            val map = mutableMapOf<String, Any>()

            // Retrieve and store values from the cursor
            val idIndex = cursor.getColumnIndex("id")
            val userIdIndex = cursor.getColumnIndex("userId")
            val titleIndex = cursor.getColumnIndex("postTitle")
            val bodyIndex = cursor.getColumnIndex("postBody")
            val userNameIndex = cursor.getColumnIndex("userName")

            if (idIndex != -1 && titleIndex != -1 && bodyIndex != -1) {
                map["Id"] = cursor.getInt(idIndex)
                map["userId"] = cursor.getInt(userIdIndex)
                map["postTitle"] = cursor.getString(titleIndex)
                map["postBody"] = cursor.getString(bodyIndex)
                map["userName"] = cursor.getString(userNameIndex)

                // Add the map to the result list
                result.add(map)
            } else {
                // Handle cases where one or more columns are missing
                println("One or more column indexes are invalid.")
            }
        }
        cursor.close()
        db.close()
        return result
    }
}


package com.example.next_data;
import static java.sql.DriverManager.println;

import android.util.Log;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseUser;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class NativeAuth {
    private final FirebaseAuth mAuth;
    private final MethodChannel channel;

    public NativeAuth(MethodChannel channel) {
        this.channel = channel;
        this.mAuth = FirebaseAuth.getInstance();
    }


    public void signInWithEmailPassword(String email, String password, MethodChannel.Result result) {
        mAuth.signInWithEmailAndPassword(email, password)
                .addOnCompleteListener(task -> {
                    if (task.isSuccessful()) {
                        result.success(null);
                    } else {
                        Exception e = task.getException();
                        String errorMessage = e != null ? e.getMessage() : "Unknown error";
                        Log.e("FirebaseAuth", "Sign-in failed: " + errorMessage);
                        result.error("SIGN_IN_FAILED", errorMessage, null);
                    }
                });
    }

    public void signUpWithEmailPassword(String email, String password, MethodChannel.Result result) {
        mAuth.createUserWithEmailAndPassword(email, password)
                .addOnCompleteListener(task -> {
                    if (task.isSuccessful()) {
                        FirebaseUser user = mAuth.getCurrentUser();
                        if (user != null) {
                            user.getIdToken(true).addOnCompleteListener(tokenTask -> {
                                if (tokenTask.isSuccessful()) {
                                    String idToken = tokenTask.getResult().getToken();
                                    Log.d("FirebaseAuth", "ID Token retrieved successfully: " + idToken);
                                    result.success(idToken);
                                } else {
                                    result.error("TOKEN_ERROR", "Failed to retrieve ID token", null);
                                }
                            });
                        } else {
                            result.error("USER_NOT_FOUND", "No user found after sign-up", null);
                        }
                    } else {
                        String errorMessage = ((FirebaseAuthException) task.getException()).getMessage();
                        result.error("SIGN_UP_FAILED", errorMessage, null);
                    }
                });
    }
}

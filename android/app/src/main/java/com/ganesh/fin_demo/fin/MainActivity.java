package com.ganesh.fin_demo.fin;

import android.Manifest;
import android.bluetooth.BluetoothAdapter;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;

import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "bluetooth_channel";
    private static final int REQUEST_ENABLE_BLUETOOTH = 123;


    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        Log.d("configureFlutterEngine", "called");
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("enableBluetooth")) {
                                Log.d("native:","called");
                                BluetoothHandler.enableBluetooth1(MainActivity.this, result);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }


}


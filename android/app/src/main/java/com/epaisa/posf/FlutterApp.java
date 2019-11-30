package com.epaisa.posf;

import android.util.Log;

import io.flutter.app.FlutterApplication;
import com.instabug.instabugflutter.InstabugFlutterPlugin;
import java.util.ArrayList;

public class FlutterApp extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        Log.e("HERE", "INSTABUG");
        ArrayList<String> invocationEvents = new ArrayList<>();
        invocationEvents.add(InstabugFlutterPlugin.INVOCATION_EVENT_FLOATING_BUTTON);
        new InstabugFlutterPlugin().start(FlutterApp.this, "0bf2e06c3290a2a5ce73be9c1b69bb11", invocationEvents);
    }
}
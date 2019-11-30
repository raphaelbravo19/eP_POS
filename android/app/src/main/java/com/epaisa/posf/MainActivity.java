package com.epaisa.posf;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;

import android.os.Handler;
import android.util.Log;

import com.epaisa.posf.teamviewwrapper.ScreenSharingWrapper;

import org.json.JSONException;
import org.json.JSONObject;

import ibt.ortc.api.Ortc;
import ibt.ortc.extensibility.OnConnected;
import ibt.ortc.extensibility.OnException;
import ibt.ortc.extensibility.OnMessage;
import ibt.ortc.extensibility.OrtcClient;
import ibt.ortc.extensibility.OrtcFactory;

public class MainActivity extends FlutterActivity implements ScreenSharingWrapper.RunningStateListener {
  private static final String CHANNEL = "crypto_plugin";
  private static final String CHANNEL_2 = "flutter_ortc_plugin";
  private static final String CHANNEL_TV = "com.epaisa.posf/tv";
  private static final String CHANNEL_DEEPLINK = "epaisapos/cnannel";
  private static final String EVENTS = "epaisapos/events";
  private BroadcastReceiver linksReceiver;
  static MethodChannel channelSink;
  // mainThread handler
  final private Handler mainHandler = new Handler();
  String startString;
  @Override
  protected void onCreate(Bundle savedInstanceState) {

    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    Intent intent = getIntent();
    Uri data = intent.getData();
    new EventChannel(getFlutterView(), EVENTS).setStreamHandler(
            new EventChannel.StreamHandler() {
              @Override
              public void onListen(Object args, final EventChannel.EventSink events) {
                linksReceiver = createChangeReceiver(events);
              }

              @Override
              public void onCancel(Object args) {
                linksReceiver = null;
              }
            }
    );
  
    new MethodChannel(getFlutterView(), CHANNEL_DEEPLINK).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        System.out.println("DEEPLINK:" + call.method);
        if (call.method.equals("initialLink")) {
          if (startString != null) {
            result.success(startString);
          }
        }
      }
    });

    if (data != null) {
      startString = data.toString();
    }
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("encrypt")) {
          result.success(EncryptionHelper.encrypt(call.argument("text").toString(), call.argument("key").toString(),
              call.argument("iv").toString()));
        } else if (call.method.equals("decrypt")) {
          result.success(EncryptionHelper.decrypt(call.argument("text").toString(), call.argument("key").toString(),
              call.argument("iv").toString()));
        } else {
          result.notImplemented();
        }
      }
    });

    new MethodChannel(getFlutterView(), CHANNEL_2).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("registerORTC")) {
          registerUser(call.argument("userpubsubtoken").toString(),
              Integer.parseInt(call.argument("storelocationid").toString()));
          // registerUser(call.argument("userpubsubtoken").toString().Integer
          // .parseInt(call.argument("storelocationid").toString()));
          result.success("");

        } else if (call.method.equals("getPlatformVersion")) {
          result.success("Android " + Build.VERSION.RELEASE);
        } else {
          result.notImplemented();
        }
      }
    });
    new MethodChannel(getFlutterView(), CHANNEL_TV).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("register")) {
          boolean running = ScreenSharingWrapper.getInstance().isSessionRunning();
          if (running) {
            ScreenSharingWrapper.getInstance().setRunningStateListener(null);
            emitSessionState(false);
          } else {
            ScreenSharingWrapper.getInstance().setRunningStateListener(MainActivity.this::emitSessionState);
            ScreenSharingWrapper.getInstance().startTeamViewerSession(MainActivity.this, "session_one");
            emitSessionState(running);
          }

        } else {
          result.notImplemented();
        }
      }
    });

    // @Override
    // public void onListen(Object o, EventChannel.EventSink eventSink) {
    // Log.e("SYNC_TAG", "onListen");
    // events = eventSink;
    // }
    //
    // @Override
    // public void onCancel(Object o) {
    // Log.e("SYNC_TAG", "onCancel");
    //
    // }
  }

  /**
   * @param pubSubToken
   * @param storeLocationId
   */
  public void registerUser(String pubSubToken, final int storeLocationId) {
    OrtcFactory factory;
    final OrtcClient client;
    Ortc ortc = new Ortc();

    try {
      factory = ortc.loadOrtcFactory("IbtRealtimeSJ");
      client = factory.createClient();
      client.setConnectionMetadata("AndroidApp");
      Log.e("SYNC_TAG", "Connect PubSub Token " + pubSubToken);
      client.setClusterUrl("http://ortc-developers.realtime.co/server/2.1");
      // client.setClusterUrl("https://ortc-india.realtime.co/server/ssl/2.1");
      client.connect("Eup1GT", pubSubToken);

      client.onException = new OnException() {
        @Override
        public void run(OrtcClient send, Exception ex) {
          // EpaisaApplication.isUserRegisterToPubSub = false;
          Log.e("Check realtime ex", ex.toString());
          System.out.println(String.format("Realtime Error: %s", ex.toString()));
        }
      };

      client.onConnected = new OnConnected() {
        @Override
        public void run(OrtcClient sender) {
          Log.e("SYNC_TAG", "OnConnected ");
          Log.e("Check realtime", "OnConnected");
          client.subscribe("store_" + storeLocationId, true, new OnMessage() {
            @Override
            public void run(OrtcClient sender, String channel, final String message) {
              Log.e("SYNC_TAG", "SYNC " + message);
              try {
                JSONObject jsonObject = new JSONObject(message);
                // t stands for total number of message in a response
                // t=1 means message contain complete response
                Log.e("SYNC_TAG", "SYNC " + (jsonObject.getInt("t")));
                if (jsonObject.getInt("t") == 1) {
                  // c stands for content
                  handleMessage(jsonObject.getString("c"));
                } else {
                  // todo In future for sync ,currently not required
                  /*
                   * //save the messages in database until you get the complete response
                   * RealTimeMessage realTimeMessage = new RealTimeMessage();
                   * realTimeMessage.setContent(jsonObject.getString("c"));
                   * realTimeMessage.setMessageId(jsonObject.getString("id"));
                   * realTimeMessage.setTotalNumberOfMessages(jsonObject.getInt("t"));
                   * realTimeMessage.setMessageNumber(jsonObject.getInt("p"));
                   * RealTimeMessagesDataSource dataSource =
                   * RealTimeMessagesDataSource.getInstance(EpaisaApplication.getInstance());
                   * dataSource.saveMessage(realTimeMessage); List<RealTimeMessage> messageList =
                   * dataSource.getMessagesForId(jsonObject.getString("id")); StringBuilder
                   * completeResponse = new StringBuilder(); if (messageList.size() ==
                   * realTimeMessage.getTotalNumberOfMessages()) { Collections.sort(messageList,
                   * new MessageNumberComparator()); for (RealTimeMessage timeMessage :
                   * messageList) { completeResponse.append(timeMessage.getContent()); }
                   * handleMessage(completeResponse.toString());
                   * dataSource.deleteMessagesWithId(realTimeMessage.getMessageId()); }
                   */

                }

              } catch (Exception e) {
                e.printStackTrace();
                Log.e("SYNC_TAG", "SYNC " + e.toString());
                Log.e("Check realtime Exce", e.toString());
              }
            }
          });
        }
      };
    } catch (Exception e) {
      Log.e("Check realtime Ex", e.toString());
      Log.e("SYNC_TAG", "SYNC " + e.toString());
      System.out.println(String.format("Realtime Error: %s", e.toString()));
    }
  }

  /*
   * private static class MessageNumberComparator implements
   * Comparator<RealTimeMessage> {
   *
   * @Override public int compare(RealTimeMessage o1, RealTimeMessage o2) { return
   * o1.getMessageNumber() < o2.getMessageNumber() ? -1 : o1.getMessageNumber() ==
   * o2.getMessageNumber() ? 0 : 1; } }
   */
  private void handleMessage(String message) throws Exception {
    final JSONObject jsonObject = new JSONObject(message);

    Log.e("SYNC_TAG", "" + jsonObject.getString("url").equals("citrusupdate"));
    Log.e("SYNC_TAG", "" + jsonObject.getString("verb"));
    Log.e("SYNC_TAG", "" + jsonObject.getString("result").toString());
    if (jsonObject.getString("url").equals("citrusupdate")) {
      switch ((jsonObject.getString("verb"))) {
      case "POST":
        // events.success(jsonObject.getJSONObject("result").toString());
        if (channelSink != null) {
          mainHandler.post(new Runnable() {
            @Override
            public void run() {
              try {
                channelSink.invokeMethod("citruscallback", jsonObject.getJSONObject("result").toString());
              } catch (JSONException e) {
                Log.e("SYNC_TAG", "ex " + e.toString());
                e.printStackTrace();
              }
            }
          });

        }
        break;

      }

    }

  }
  @Override
  public void onNewIntent(Intent intent){
    super.onNewIntent(intent);
    if(intent.getAction() == android.content.Intent.ACTION_VIEW && linksReceiver != null) {
      linksReceiver.onReceive(this.getApplicationContext(), intent);
    }
  }


  private BroadcastReceiver createChangeReceiver(final EventChannel.EventSink events) {
    return new BroadcastReceiver() {
      @Override
      public void onReceive(Context context, Intent intent) {
        // NOTE: assuming intent.getAction() is Intent.ACTION_VIEW

        String dataString = intent.getDataString();

        if (dataString == null) {
          events.error("UNAVAILABLE", "Link unavailable", null);
        } else {
          events.success(dataString);
        }
        ;
      }
    };
  }
  /**
   * Will be called on running state changes of the TeamViewer session.
   *
   * @param isRunning New session state.
   */
  @Override
  public void onRunningStateChange(boolean isRunning) {
    boolean buttonEnabled = !ScreenSharingWrapper.getInstance().isSessionRunning();
    emitSessionState(buttonEnabled);
  }

  private void emitSessionState(boolean buttonEnabled) {
    Log.e("buttonEnabled", String.valueOf(buttonEnabled));
    /*
     * WritableMap payload = Arguments.createMap(); // Put data to map
     * payload.putBoolean("isRunning", buttonEnabled); reactContext
     * .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
     * .emit("teamViewerSessionState", payload); //
     * txtShareScreen.setEnabled(buttonEnabled);
     */
  }
}

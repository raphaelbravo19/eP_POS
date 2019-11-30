package io.flutter.plugins.com.ortc.flutter_ortc_plugin;

import android.os.Handler;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import ibt.ortc.api.Ortc;
import ibt.ortc.extensibility.OnConnected;
import ibt.ortc.extensibility.OnException;
import ibt.ortc.extensibility.OnMessage;
import ibt.ortc.extensibility.OrtcClient;
import ibt.ortc.extensibility.OrtcFactory;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterOrtcPlugin
 */
public class FlutterOrtcPlugin implements MethodCallHandler/* , EventChannel.StreamHandler */ {
    /*
     * public static final String STREAM = "com.epaisa.eventchannel/stream";
     * 
     * private EventChannel.EventSink events;
     */
    static MethodChannel channelSink;
    // mainThread handler
    final private Handler mainHandler = new Handler();

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_ortc_plugin");
        channel.setMethodCallHandler(new FlutterOrtcPlugin());

        channelSink = channel;

        /*
         * final EventChannel eventChannel = new EventChannel(registrar.messenger(),
         * STREAM); eventChannel.setStreamHandler(new FlutterOrtcPlugin());
         */

    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("registerORTC")) {
            registerUser(call.argument("userpubsubtoken").toString(),Integer
                    .parseInt(call.argument("storelocationid").toString()));
            result.success("");

        } else if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else {
            result.notImplemented();
        }
    }

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
                                channelSink.invokeMethod("citruscallback",
                                        jsonObject.getJSONObject("result").toString());
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
}
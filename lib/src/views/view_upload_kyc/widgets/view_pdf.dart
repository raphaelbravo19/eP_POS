import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class FullPdfViewerScreen extends StatelessWidget {
  //final String pdfPath;

  //FullPdfViewerScreen();

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
        ),
        path: "https://bit.ly/2k1liS4");
  }
}


class ViewPDF extends StatefulWidget {
  @override
  _ViewPDFState createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {

  InAppWebViewController webView;
  String url = "https://flutter.io/";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inline WebView example app'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text("CURRENT URL\n${ (url.length > 50) ? url.substring(0, 50) + "..." : url }"),
          ),
          (progress != 1.0) ? LinearProgressIndicator(value: progress) : null,
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)
              ),
              child: InAppWebView(
                initialUrl: "https://bit.ly/2k1liS4",
                initialHeaders: {

                },
                initialOptions: {

                },
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  print("started $url");
                  setState(() {
                    this.url = url;
                  });
                },
                onProgressChanged: (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress/100;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class MyInAppBrowser extends InAppBrowser {

  @override
  Future onLoadStart(String url) async {
    print("\n\nStarted $url\n\n");
  }

  @override
  Future onLoadStop(String url) async {
    print("\n\nStopped $url\n\n");
  }

  @override
  void onLoadError(String url, int code, String message) {
    print("\n\nCan't load $url.. Error: $message\n\n");
  }

  @override
  void onExit() {
    print("\n\nBrowser closed!\n\n");
  }

}

MyInAppBrowser inAppBrowserFallback = new MyInAppBrowser();

class MyChromeSafariBrowser extends ChromeSafariBrowser {

  MyChromeSafariBrowser(browserFallback) : super(browserFallback);

  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onLoaded() {
    print("ChromeSafari browser loaded");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

MyChromeSafariBrowser chromeSafariBrowser = new MyChromeSafariBrowser(inAppBrowserFallback);


class ChromeBrowser extends StatefulWidget {
  @override
  _ChromeBrowserState createState() => new _ChromeBrowserState();
}

class _ChromeBrowserState extends State<ChromeBrowser> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Flutter InAppBrowser Plugin example app'),
        ),
        body: new Center(
          child: new RaisedButton(onPressed: () {
            chromeSafariBrowser.open("https://bit.ly/2k1liS4", options: {
              "addShareButton": false,
              "toolbarBackgroundColor": "#000000",
              "dismissButtonStyle": 1,
              "preferredBarTintColor": "#000000",
            },
                optionsFallback: {
                  "toolbarTopBackgroundColor": "#000000",
                  "closeButtonCaption": "Close"
                });
          },
              child: Text("Open ChromeSafariBrowser")
          ),
        ),
      ),
    );
  }
}

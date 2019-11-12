import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('웹뷰'),
            onPressed: () async {
              final address = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyWebView()),
              );

              setState(() {
                _address = address;
              });
            },
          ),
          Text('$_address'),
        ],
      ),
    );
  }
}

class MyWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'http://oh8112191.cafe24.com/android/zipcode/daum_zipcode_flutter.html',
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: {
        JavascriptChannel(
          name: 'andjs',
          onMessageReceived: (JavascriptMessage message) {
            print(message.message);
            Navigator.pop(context, message.message);
          },
        ),
      },
    );
  }
}


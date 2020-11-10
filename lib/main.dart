import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/services.dart';
import 'dart:io';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<String> devicesList = new List<String>();

  void _incrementCounter() {

  }
  caller() async {
    this.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        String result2 = result.device.id.toString();
        print('$result2');
        _addDeviceTolist(result2);
      }
    });
    this.flutterBlue.startScan();
  }
  Future<void> startService() async {
    if(Platform.isAndroid) {
      var methodChannel=MethodChannel("com.example.messages");
      String data=await methodChannel.invokeMethod("startService");
      methodChannel.setMethodCallHandler((MethodCall call){
        print('wtf:$call');
        return caller();
      });
      debugPrint(data);
    }
  }
  _addDeviceTolist(final String device) {
    if (!this.devicesList.contains(device)) {
      setState(() {
        this.devicesList.add(device);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startService();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

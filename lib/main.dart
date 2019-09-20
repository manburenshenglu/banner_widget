import 'package:banner_widget/widget/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<BannerItem> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BannerItem item = BannerItem.defaultBannerItem(
        'http://n.sinaimg.cn/sports/transform/0/w500h300/20190814/14d8-icapxpi4070373.jpg',
        'LeBron James');
    data.add(item);
    item = BannerItem.defaultBannerItem(
        'http://img.mp.itc.cn/upload/20170106/a87363f5c7e548ec8022b5cadfc1c216_th.jpg',
        'LeBron&Wade');
    data.add(item);
    item = BannerItem.defaultBannerItem(
        'http://02.imgmini.eastday.com/mobile/20180328/20180328212318_1ef989a9c001edab4c94578141c10f18_2.jpeg',
        'LeBron VS Wade');
    data.add(item);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            BannerWidget(data,
                duration: 2000,
                height: 200.0,
                selectedColor: Colors.red,
                unSelectedColor: Colors.white,
                onBannerItemClick: (int position, BannerItem item) {
                  Fluttertoast.showToast(
                      msg: 'index=$position banner is clicked！',
                      toastLength: Toast.LENGTH_LONG);
                },
                build: null,
                descriptionBackgroundColor: const Color(0x33000000),
                textInfoDirect: InfoDirect.HORIZONTAL,
                circleRadius: 5.0,
                indicatorStyle: IndicatorStyle.ELLIPTICAL,
                ellipticalWidth: 16.0,
                ellipticalHeight: 8.0,
                cornerRadius: 10.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

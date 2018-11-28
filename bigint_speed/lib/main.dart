import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'BigInt Speed'),
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
  Duration _duration;

  void _goCompute() {
    compute(timedTest,null,debugLabel: "Timed Test")
        .then(setDuration);

  }

  int setDuration(Duration duration) { setState(() { _duration = duration; }); }
  String get duration => _duration == null ? "No results" : "It took " + _duration.toString();

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
            Text(duration,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goCompute,
        tooltip: 'Go',
        child: Icon(Icons.add),
      ),
    );
  }

  static Duration timedTest(x) {
    final start = now();
    testBigIntSpeed();
    final end = now();
    return end.difference(start);
  }

  static testBigIntSpeed() {
    var x = BigInt.from(5);
    var y = BigInt.from(2);
    for (int i=0; i<7; i++) {
      x = x.pow(5);
      y = y.pow(3) + BigInt.from(1);
      perf("$i",() => x.modPow(x, y) );
    }
  }

  static perf(message, f) {
    final start = now();
    final result = f();
    final end = now();
    final duration = end.difference(start);
    print("$message $duration");
    return result;
  }
  
  static now() => DateTime.now();
}

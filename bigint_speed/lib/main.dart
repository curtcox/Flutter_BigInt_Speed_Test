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
  bool _running = false;
  String _results;

  void _goCompute() {
    setState(() { _running = true; });
    compute(timedTest,null,debugLabel: "Timed Test")
        .then(setDuration);
  }

  void setDuration(String duration) {
    setState(() {
      _results = duration;
      _running = false;
    });
  }
  String get duration => _results == null ? "Tap the button to generate new times." : _results;

  Widget _computeButton() {
    return new RaisedButton(
      child: new Text(
          _running ? "Computing..." : "Compute"
      ),
      onPressed: _running ? null : _goCompute,
    );
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
            Text(duration,),
            _computeButton(),
          ],
        ),
      ),
    );
  }

  static String timedTest(x) {
    var out = "";
    var x = BigInt.from(5);
    var y = BigInt.from(2);

    for (int i=1; i<8; i++) {
      x = x.pow(5);
      y = y.pow(3) + BigInt.from(1);
      out = out + "$i " + perf(() => x.modPow(x, y) ) + "\n";
    }
    return out;
  }

  static String perf(f) {
    final start = now();
    final result = f();
    final end = now();
    final duration = end.difference(start);
    final message = "$duration ${result.bitLength}";
    print(message);
    return message;
  }
  
  static now() => DateTime.now();
}

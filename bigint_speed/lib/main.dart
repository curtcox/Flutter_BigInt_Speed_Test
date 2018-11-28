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

  int setDuration(Duration duration) {
    setState(() { _duration = duration; });
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
            Text('It took this long',),
            Text('$_duration',),
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
    final start = DateTime.now();
    final end = DateTime.now();
    return end.difference(start);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
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
  static const String _operatorAdd = '+';
  static const String _operatorSub = '-';
  static const String _operatorMul = 'x';
  static const String _operatorDiv = ':';
  static const String _operatorRes = 'Reset';
  static const String _stringEmpty = '';
  final _resultResultTextPrefix = 'Ket qua la: ';
  static const double _defaultResultValue = 0;
  final double _fontSize = 25;
  TextEditingController _numberAController = new TextEditingController();
  TextEditingController _numberBController = new TextEditingController();
  String _result;

  _MyHomePageState() {
    _result = _resultResultTextPrefix + '$_defaultResultValue';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('images/calculator.png'),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                width: double.infinity,
                height: 40,
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _numberAController,
                    style: TextStyle(fontSize: _fontSize),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    //
                    decoration:
                        new InputDecoration.collapsed(hintText: 'Nhap so A')),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                width: double.infinity,
                height: 40,
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _numberBController,
                    style: TextStyle(fontSize: _fontSize),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    //
                    decoration:
                        new InputDecoration.collapsed(hintText: 'Nhap so B')),
              ),
              Container(
                  width: double.infinity,
                  height: 40,
                  child: Text(
                    _result,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: _fontSize),
                  )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.blue,
                        onPressed: () => _onPressedOperatorButton(_operatorAdd),
                        child: Text(_operatorAdd,
                            style: TextStyle(
                                color: Colors.white, fontSize: _fontSize))),
                    RaisedButton(
                        color: Colors.deepOrange,
                        onPressed: () => _onPressedOperatorButton(_operatorSub),
                        child: Text(_operatorSub,
                            style: TextStyle(
                                color: Colors.white, fontSize: _fontSize))),
                    RaisedButton(
                        color: Colors.green,
                        onPressed: () => _onPressedOperatorButton(_operatorMul),
                        child: Text(_operatorMul,
                            style: TextStyle(
                                color: Colors.white, fontSize: _fontSize))),
                    RaisedButton(
                        color: Colors.yellowAccent,
                        onPressed: () => _onPressedOperatorButton(_operatorDiv),
                        child: Text(_operatorDiv,
                            style: TextStyle(
                                color: Colors.white, fontSize: _fontSize))),
                  ]),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                    color: Colors.grey,
                    onPressed: () => _onPressedOperatorButton(_operatorRes),
                    child: Text(_operatorRes,
                        style: TextStyle(color: Colors.white, fontSize: _fontSize))),
              ),
            ],
          ),
        ));
  }

  void _onPressedOperatorButton(String operator) {
    double numberA = _defaultResultValue;
    double numberB = _defaultResultValue;
    double result = _defaultResultValue;
    try {
      numberA = double.parse(_numberAController.text);
    } on Exception catch (exception) {
      numberA = _defaultResultValue;
    }
    try {
      numberB = double.parse(_numberBController.text);
    } on Exception catch (exception) {
      numberB = _defaultResultValue;
    }
    switch (operator) {
      case _operatorAdd:
        {
          result = numberA + numberB;
        }
        break;
      case _operatorSub:
        {
          result = numberA - numberB;
        }
        break;
      case _operatorMul:
        {
          result = numberA * numberB;
        }
        break;
      case _operatorDiv:
        {
          result = (numberB == _defaultResultValue)
              ? _defaultResultValue
              : numberA / numberB;
        }
        break;
      default:
        {
          // Reset
          result = _defaultResultValue;
          _numberAController.text = _stringEmpty;
          _numberBController.text = _stringEmpty;
        }
        break;
    }
    _result = _resultResultTextPrefix + '$result';
    setState(() {});
  }
}

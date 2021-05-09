import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double a = 0;
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
        equationFontSize = 38.0;
        resultFontSize = 48.0;

      } else if (buttonText == '⇚') {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        result = '0';
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '＝') {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('✕', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('-', '-');
        expression = expression.replaceAll('＋', '+');
        expression = expression.replaceAll('tan', 'tan');
        expression = expression.replaceAll('sin', 'sin');
        expression = expression.replaceAll('cos', 'cos');
        expression = expression.replaceAll('π', '3.1415926535897932');
        expression = expression.replaceAll('^', '^');
        expression = expression.replaceAll('√', 'sqrt');

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';

        } catch (e) {
          result = 'Error';
        }

      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget button(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.085 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        button('sin', 1, Color.fromRGBO(126,113,133, 1)),
                        button('cos', 1, Color.fromRGBO(126,113,133, 1)),
                        button('tan', 1, Color.fromRGBO(126,113,133, 1)),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('C', 1, Color.fromRGBO(235,174,56, 1)),
                        button('^', 1, Color.fromRGBO(126,113,133, 1)),
                        button('π', 1, Color.fromRGBO(126,113,133, 1)),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('⇚', 1, Color.fromRGBO(126,113,133, 1)),
                        button('(', 1, Color.fromRGBO(126,113,133, 1)),
                        button(')', 1, Color.fromRGBO(126,113,133, 1)),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('7', 1, Color.fromRGBO(110,193,176, 1)),
                        button('8', 1, Color.fromRGBO(110,193,176, 1)),
                        button('9', 1, Color.fromRGBO(110,193,176, 1)),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('4', 1, Color.fromRGBO(110,193,176, 1)),
                        button('5', 1, Color.fromRGBO(110,193,176, 1)),
                        button('6', 1, Color.fromRGBO(110,193,176, 1)),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('1', 1, Color.fromRGBO(110,193,176, 1)),
                        button('2', 1, Color.fromRGBO(110,193,176, 1)),
                        button('3', 1, Color.fromRGBO(110,193,176, 1)),
                      ],
                    ),
                    TableRow(
                      children: [
                        button('.', 1, Color.fromRGBO(110,193,176, 1)),
                        button('0', 1, Color.fromRGBO(110,193,176, 1)),
                        button('00', 1, Color.fromRGBO(110,193,176, 1)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      button('√', 1, Color.fromRGBO(126,113,133, 1)),
                    ]),
                    TableRow(children: [
                      button('÷', 1, Color.fromRGBO(126,113,133, 1)),
                    ]),
                    TableRow(children: [
                      button('✕', 1, Color.fromRGBO(126,113,133, 1)),
                    ]),
                    TableRow(children: [
                      button('-', 1, Color.fromRGBO(126,113,133, 1)),
                    ]),
                    TableRow(children: [
                      button('＋', 1, Color.fromRGBO(126,113,133, 1)),
                    ]),
                    TableRow(children: [
                      button('＝', 2, Color.fromRGBO(235,174,56, 1)),
                    ])
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

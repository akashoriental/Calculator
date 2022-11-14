import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:calculator/preferences.dart';
void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Mycalci(),
  ));
}

class Mycalci extends StatefulWidget {
  const Mycalci({Key? key}) : super(key: key);

  @override
  State<Mycalci> createState() => _MycalciState();
}

class _MycalciState extends State<Mycalci> {
  dynamic result='0';
  @override
  void initState(){
    super.initState();
    // TODO: implement initState
    Future.delayed(Duration.zero,()async
    {
      await UserPreferences.init();
      result = await UserPreferences.getval();
    });
  }
  double? width;
  double? height;
  Widget drawButton(String text, Color btncol, Color txtcol,[IconData? ic]) {
    return ElevatedButton(
      onPressed: () {
        //To do simething here
        calcute(text);
      },
      style: (width!<400)?ElevatedButton.styleFrom(
        backgroundColor: (btncol),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: (RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        )),
      ):ElevatedButton.styleFrom(
        backgroundColor: (btncol),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: (RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        )),
      ),
      child: (text!='<')?Text(
        text,
        style: TextStyle(
          fontSize: 40,
          color: txtcol,
        ),
      ):Icon(ic,size: 40,color: Colors.black,),
    );
  }

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    print(width);
    print(height);
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: const Text('copyright'),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$result',
                      style: const TextStyle(color: Colors.white, fontSize: 100),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                drawButton('AC', Colors.grey, Colors.black),
                drawButton('+-', Colors.grey, Colors.black),
                drawButton('%', Colors.grey, Colors.black),
                drawButton('/', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                drawButton('7', Colors.grey, Colors.black),
                drawButton('8', Colors.grey, Colors.black),
                drawButton('9', Colors.grey, Colors.black),
                drawButton('X', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                drawButton('4', Colors.grey, Colors.black),
                drawButton('5', Colors.grey, Colors.black),
                drawButton('6', Colors.grey, Colors.black),
                drawButton('-', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                drawButton('1', Colors.grey, Colors.black),
                drawButton('2', Colors.grey, Colors.black),
                drawButton('3', Colors.grey, Colors.black),
                drawButton('+', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                drawButton('<', Colors.grey, Colors.black,Icons.backspace_rounded),
                drawButton('0', Colors.grey, Colors.black),
                drawButton('.', Colors.grey, Colors.black),
                drawButton('=', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  int count = 0;
  dynamic first = 0;
  dynamic second = 0;
  dynamic operator = '';
  String preres = '';
  //yk
  dynamic res = '';
  void calcute(String presbtn) {
    if (presbtn == '.') count++;
    if (presbtn == 'AC') {
      result = '';
      preres = '';
      res = '';
      first = 0;
      second = 0;
      count = 0;
    } else if (presbtn == '+' || presbtn == '-' || presbtn == 'X' || presbtn == '/' || presbtn == '=' || presbtn == '%') {
      if (first == 0) {
        first = double.parse(double.parse(preres).toStringAsFixed(2));
        count = 0;
      } else {
        if (preres != '') second = double.parse(preres);
        count=0;
      }
      if(first!=0 && second!=0) {
        if (operator == '+')
          res = add();
        else if (operator == '-')
          res = sub();
        else if (operator == 'X')
          res = mul();
        else if (operator == '/')
          res = div();
        else if (operator == '%')
          res = per();
      }
      operator = presbtn;
      preres = '';
    } else if (presbtn == '+-') {
      preres = preres.toString().startsWith('-') ? preres.toString().substring(1) : '-$preres';
      res = preres;
    } else if (presbtn == '<') {
      setState(() {
        String dot=res.toString().substring(res.toString().length-1);
        if(dot=='.')
          count=0;
        res = res.toString().substring(0,res.toString().length-1);
        preres=res;
        if(preres!='')
        first = double.parse(double.parse(preres).toStringAsFixed(2));
      });
    } else {
      if (count == 1 || presbtn != '.') {
        preres = preres + presbtn;
      } else {
        final snack = SnackBar(
          content: Text('You pressed the wrong key'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack);
      }
      res = preres;
    }
    setState((){
      result = res;
      Future.delayed(Duration.zero,()async{
      await UserPreferences.setval(result);
      });
    });
  }

  String add() {
    res = (first + second).toString();
    if (res.length >= 6) {
      Alert(context: context, title: 'WARNING', desc: 'The result has gone beyond user expectation').show();
      res = '';
    }
    first = double.parse(double.parse(res).toStringAsFixed(2));
    operator = '';
    return containdeci(res);
  }

  String sub() {
    res = (first - second).toString();
    first = double.parse(double.parse(res).toStringAsFixed(2));
    operator = '';
    return containdeci(res);
  }

  String mul() {
    res = (first * second).toString();
    first = double.parse(double.parse(res).toStringAsFixed(2));
    operator = '';
    return containdeci(res);
  }

  String div() {
    res = (first / second).toString();
    first = double.parse(double.parse(res).toStringAsFixed(2));
    operator = '';
    return containdeci(res);
  }

  String per() {
    res = ((first * 100) / second).toString();
    operator = '';
    return containdeci(res);
  }

  String containdeci(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      print(splitDecimal[0]);
      print(splitDecimal[1]);
      if (!(int.parse(splitDecimal[1]) > 0)) return result = splitDecimal[0].toString();
      result=double.parse(result).toStringAsFixed(2);
    }
    return result;
  }
}

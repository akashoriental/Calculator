import 'package:flutter/material.dart';

void main()=> runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Mycalci(),
));
class Mycalci extends StatefulWidget {
  const Mycalci({Key? key}) : super(key: key);

  @override
  State<Mycalci> createState() => _MycalciState();
}

class _MycalciState extends State<Mycalci> {
  dynamic result='0';
  Widget drawButton(String text, Color btncol , Color txtcol){
    return ElevatedButton(
      onPressed: (){
        //To do simething here
        calcute(text);
      },
      child: Text('$text',
      style: TextStyle(
        fontSize: 40,
        color: txtcol,
      ),
      ),
      style: ElevatedButton.styleFrom(backgroundColor:(btncol),padding: (EdgeInsets.symmetric(horizontal: 30,vertical: 20)),shape:(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
          )

      ),),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text('copyright to akash garg'),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(10.0),
                  child: Text('$result',
                  style: TextStyle(color: Colors.white,fontSize: 100),
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
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                drawButton('7', Colors.grey, Colors.black),
                drawButton('8', Colors.grey, Colors.black),
                drawButton('9', Colors.grey, Colors.black),
                drawButton('X', Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                drawButton('4', Colors.grey, Colors.black),
                drawButton('5', Colors.grey, Colors.black),
                drawButton('6', Colors.grey, Colors.black),
                drawButton('-', Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                drawButton('1', Colors.grey, Colors.black),
                drawButton('2', Colors.grey, Colors.black),
                drawButton('3', Colors.grey, Colors.black),
                drawButton('+', Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                drawButton('<>', Colors.grey, Colors.black),
                drawButton('0', Colors.grey, Colors.black),
                drawButton('.', Colors.grey, Colors.black),
                drawButton('=', Colors.amber, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  dynamic first=0;
  dynamic second=0;
  dynamic operator='';
  dynamic preres='';
  dynamic res='';
  void calcute(String presbtn){
    if(presbtn=='AC') {
         result='';
         preres='';
         res='';
         first=0;
         second=0;
    }
    else if(presbtn=='+' || presbtn=='-' || presbtn=='X' || presbtn=='/' || presbtn=='=' || presbtn=='%'){
        if(first==0)
          first=double.parse(preres);
        else
          second=double.parse(preres);
        if(operator=='+')
          res=add();
        else if(operator=='-')
          res=sub();
        else if(operator=='X')
          res=mul();
        else if(operator=='/')
          res=div();
        else if(operator=='%')
          res=per();
        operator=presbtn;
        preres='';
    }
    else if(presbtn=='+-'){
      preres=preres.toString().startsWith('-')?preres.toString().substring(1):'-'+preres.toString();
      res=preres;
    }
    else{
      preres=preres+presbtn;
      res=preres;
    }
    setState(() {
      result=res;
    });
  }
  String add(){
    res=(first+second).toString();
    first=double.parse(res);
    return res;
  }
  String sub(){
    res=(first-second).toString();
    first=double.parse(res);
    return res;
  }
  String mul(){
    res=(first*second).toString();
    first=double.parse(res);
    return res;
  }
  String div(){
    res=(first/second).toString();
    first=double.parse(res);
    return res;
  }
  String per(){
    res=(first/100).toString();
    return res;
  }
}



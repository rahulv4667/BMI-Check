import 'package:flutter/material.dart';


class BmiUi extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BMIState();
  }
}

class BMIState extends State<BmiUi>{

  bool heightRadio=false;
  bool weightRadio=false;
  String heightFeetField="Feet";
  String heightInchField="Inch";
  String weightHint="In lbs";
  final TextEditingController _ageController=new TextEditingController();
  final TextEditingController _feetController=new TextEditingController();
  final TextEditingController _inchesController=new TextEditingController();
  final TextEditingController _weightController=new TextEditingController();
  String bmiIndicator="Enter details";
  String bmiStatus="status";

  void weightChanged(bool value){
    setState(() {
      weightRadio=value;
      if(weightRadio==true){
        weightHint="In KGs";
      }
      else{
        weightHint="In lbs";
      }
    });
  }

  void heightChanged(bool value) {
    setState(() {
      heightRadio = value;
      if (heightRadio == true) {
        heightFeetField = "Metres";
        heightInchField = "Centimetres";
      }
      else {
        heightFeetField = "Feet";
        heightInchField = "Inch";
      }
    });
  }

  void calculateBMI(){
    num bmi;
    setState(() {
      if(_feetController.text.isNotEmpty&&_inchesController.text.isNotEmpty&&_weightController.text.isNotEmpty){
        if(heightRadio&&!weightRadio){

          num weight=num.parse(_weightController.text);
          num height=num.parse(_feetController.text);
          height=height*100;
          height=height+num.parse(_inchesController.text);
          weight=weight*0.453592;
          bmi=(weight/(height*height))*10000;
          bmi=num.parse(bmi.toStringAsFixed(2));
          bmiIndicator="BMI: "+bmi.toString();

        }
        else if(!heightRadio&&weightRadio){

          num weight=num.parse(_weightController.text);
          num height=num.parse(_feetController.text);
          weight=weight*2.20462;
          height=height*12;
          height+=num.parse(_inchesController.text);
          bmi=(weight/(height*height))*703;
          bmi=num.parse(bmi.toStringAsFixed(2));
          bmiIndicator="BMI: "+bmi.toString();

        }
        else if(heightRadio&&weightRadio){
          num weight=num.parse(_weightController.text);
          num height=num.parse(_feetController.text);
          height=height*100;
          height=height+num.parse(_inchesController.text);
          bmi=(weight/(height*height))*10000;
          bmi=num.parse(bmi.toStringAsFixed(2));
          bmiIndicator="BMI: "+bmi.toString();
        }
        else{
          num weight=num.parse(_weightController.text);
          num height=num.parse(_feetController.text);
          height=height*12;
          height=height+num.parse(_inchesController.text);
          bmi=(weight/(height*height))*703;
          bmi=num.parse(bmi.toStringAsFixed(2));
          bmiIndicator="BMI: "+bmi.toString();
        }

        if(bmi<18.5){
          bmiStatus="You are UNDERWEIGHT";
        }
        else if(bmi>=18.5&&bmi<25.0){
          bmiStatus="You are NORMAL";
        }
        else if(bmi>=25.0&&bmi<30.0){
          bmiStatus="You are OVERWEIGHT";
        }
        else {
          bmiStatus="You are OBESE. You need to hit the gym";
        }
        
        showDialog(context: context,
                builder: (context)=>new AlertDialog(
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Close',style: new TextStyle(color: Colors.purpleAccent),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  content: new SingleChildScrollView(
                    child: new ListBody(
                      children: <Widget>[
                        new Text(bmiIndicator,style: new TextStyle(color: Colors.purple,fontSize: 24.0),),
                        new Padding(padding: const EdgeInsets.only(top: 30.0)),
                        new Center(child:new Text(bmiStatus,style: new TextStyle(color: Colors.purple.shade200,fontSize: 20.0,
                                                  fontWeight: FontWeight.w800),)),
                      ],
                    ),

                  ),
                ));
      }

      else{
        showDialog(context: context,
                builder: (context)=>new AlertDialog(
                  content: new Text("Seems like you forgot to type something!!"),
                  actions: <Widget>[
                    new FlatButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: new Text('Close',style: new TextStyle(color: Colors.purpleAccent),))
                  ],
                ));
      }


    });
  }





  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(


      appBar: new AppBar(
        title: new Text("BMI Finder"),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
      ),



      body: new Container(


        child:new ListView(

          children: <Widget>[

                new Padding(padding: const EdgeInsets.only(top:20.0)),
                new Image.asset('images/bmilogo.png',
                                height: 90.0,),

                new Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  color: Colors.grey.shade300,

                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[


                      new TextField(
                        controller: _ageController,
                        decoration: new InputDecoration(
                          labelText: "Age",
                          labelStyle: new TextStyle(fontSize: 20.0),
                          icon: new Icon(Icons.schedule),


                        ),

                        keyboardType: TextInputType.number,
                      ),


                      new Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: new Row(
                          children: <Widget>[
                            new Radio(value: false, groupValue: heightRadio, onChanged: heightChanged,activeColor: Colors.purpleAccent,),
                            new Text("In feet"),
                            new Radio(value: true, groupValue: heightRadio, onChanged: heightChanged,activeColor: Colors.purpleAccent),
                            new Text("In metres"),
                          ],
                        ),
                      ),

                      new Container(

                        child:new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            new Expanded(
                              child: new TextField(
                                controller: _feetController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: heightFeetField,
                                  labelStyle: new TextStyle(fontSize: 20.0),
                                  icon: new Icon(Icons.accessibility),


                                ),
                              ),
                            ),

                            new Padding(padding: const EdgeInsets.only(left: 20.0)),
                            new Expanded(
                              child:new TextField(
                                controller: _inchesController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: heightInchField,
                                  labelStyle: new TextStyle(fontSize: 20.0),
                                  border: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.red
                                      )
                                  ),


                                ),
                              ),
                            ),



                          ],
                        ),
                      ),


                      new Padding(padding: const EdgeInsets.only(top: 30.0)),

                      new Row(
                        children: <Widget>[
                          new Radio(value: false, groupValue: weightRadio, onChanged: weightChanged,activeColor: Colors.purpleAccent),
                          new Text("Pounds"),
                          new Radio(value: true, groupValue: weightRadio, onChanged: weightChanged,activeColor: Colors.purpleAccent),
                          new Text("Kilograms"),
                        ],
                      ),

                       new TextField(
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: "Weight",
                                  hintText: weightHint,
                                  labelStyle: new TextStyle(fontSize: 20.0),
                                  icon: new Icon(Icons.dehaze),
                                  fillColor: Colors.green,

                                ),
                              ),


                      new Padding(padding: const EdgeInsets.only(top: 30.0)),


                      new Center(
                        child: new RaisedButton(onPressed: calculateBMI,
                          child: new Text("Calculate"),
                          textColor: Colors.white,
                          color: Colors.purpleAccent,),
                      ),

                    ],
                  ),
                ),

          ],
        ),
      ),

    );
  }

}
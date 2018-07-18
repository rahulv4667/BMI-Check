import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() async{
  List _data=await jsonData();

  //print(_data);

  runApp(new MaterialApp(
    theme: new ThemeData(
      primaryColor: Colors.orange,
    ),
    
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("JSON parse"),
        centerTitle: true,
        //backgroundColor: Colors.orange,
      ),
      
      body: new ListView.builder(
          itemCount:  _data.length,
          padding: const EdgeInsets.all(14.5),
          itemBuilder: (BuildContext context, int position){
            return Column(
              children: <Widget>[
                new Divider(height: 5.5,),
                new ListTile(
                  title: new Text(_data[position]['title'],
                          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                  subtitle: new Text(_data[position]['body'],
                    style: new TextStyle(color: Colors.grey, fontSize: 16.0),),
                  leading: new CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: new Text(_data[position]['title'][0].toUpperCase(),
                              style: new TextStyle(fontSize: 16.0),),
                  ),
                  onTap: ()=>_showMessage(context,_data[position]['body']),
                ),
              ],
            );
          },
      ),
      
    ),
    
  ));
}


void _showMessage(BuildContext context, String message){
  showDialog(context: context,
          builder: (context)=>AlertDialog(
            title: Text("My App"),
            content: Text(message),
            actions: <Widget>[
              FlatButton(onPressed: ()=>Navigator.pop(context), child: Text("OK"))
            ],
          ),
  );
}

Future<List> jsonData() async{
  String apiUrl='https://jsonplaceholder.typicode.com/posts';

  http.Response response= await http.get(apiUrl);

  return json.decode(response.body);
}

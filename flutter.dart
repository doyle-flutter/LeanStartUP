import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  dynamic pData;

  @override
  void initState() {
    Future.microtask(() async => await this._getData())
      .then((dynamic data) => this.pData = data)
      .then((_) => setState((){}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("LeanStartUP"),),
    body: this.pData == null
      ? Center(child: Text("Loading..."),)
      : this.pData == false
        ? Center(child: Text("ERROR!"),)
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute( builder: (BuildContext context) => Scaffold(
                  appBar: AppBar(title: Text("Product Page $index"),),
                ))
              ),
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Text(index.toString()),
              ),
            )
          ),
  );

  Future<dynamic> _getData() async{
    const String _server = 'http://127.0.0.1:3000';
    final http.Response _res = await http.get(_server);
    if(_res.statusCode != 200) return false;
    return json.decode(_res.body);
  }
}

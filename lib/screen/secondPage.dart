import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lastPage.dart';

class secondPage extends StatefulWidget
{
  final String secondPageName;
  final List<String> historicalPlaces;
  final int index;


  const secondPage({super.key, required this.secondPageName, required this.historicalPlaces, required this.index});

  @override
  State<secondPage> createState() => _secondPageState();
}

class _secondPageState extends State<secondPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.secondPageName),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Container(
                height: 200,
                child: Image.network("https://unbought-milk.000webhostapp.com/images/download%20(1).jpg"),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 23),
                  child: Text("Info", style: TextStyle(color: Colors.blueGrey, fontSize: 22, fontWeight: FontWeight.bold),)
              ),

              Container(
                padding: EdgeInsets.only(left: 23, right: 23, top: 20),
                child: Text(widget.historicalPlaces[widget.index]),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
      FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LastPage()));
          }
      ),
    );
  }
}

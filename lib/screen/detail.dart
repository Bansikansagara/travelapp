import 'dart:convert';
import 'package:travelapp/screen/secondPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class detail extends StatefulWidget {
  final String detailName;
  final List<String> jsonData;

  const detail({Key? key, required this.detailName, required this.jsonData}) : super(key: key);

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {

  late List<String> historicalPlaces;

  @override
  void initState() {
    super.initState();
    historicalPlaces = []; // Initialize historicalPlaces here
  }


  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.detailName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  if (widget.jsonData[index] == "ALFRED HIGH SCHOOL") {
                    historicalPlaces = await viewHistoricalPlaces();
                    if (historicalPlaces.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              secondPage(
                                secondPageNam-e: widget.jsonData[index],
                                historicalPlaces: historicalPlaces,
                                index: index,
                              ),
                        ),
                      );
                    } else {
                      print("Historical places list is empty");
                    }
                  }
                  print(index);
                },

                child: ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.lightBlue,
                  ),
                  title: Text(widget.jsonData[index]),
                  trailing: IconButton(
                    onPressed: () async
                    {
                      if (widget.jsonData[index] == "ALFRED HIGH SCHOOL") {
                        historicalPlaces = await viewHistoricalPlaces();
                        if (historicalPlaces.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  secondPage(
                                    secondPageName: widget.jsonData[index],
                                    historicalPlaces: historicalPlaces,
                                    index: index,
                                  ),
                            ),
                          );
                        } else {
                          print("Historical places list is empty");
                        }
                      }
                    },
                    icon: Icon(Icons.navigate_next_sharp),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black,
                height: 1, // Adjust the height of the divider line
              );
            },
            itemCount: widget.jsonData.length,
          ),
        ),
      ),
    );
  }


  Future<List<String>> viewHistoricalPlaces() async
  {
      print("Calling viewHistoricalPlaces");
      try {
        final response = await http.get(Uri.parse(
            "https://begrimed-executions.000webhostapp.com/travel_guidance.php/historical_places.php/historical_places_view.php"));

        List<dynamic> decodedData = jsonDecode(response.body);

        if (decodedData is List) {
          List<String> extractedData = decodedData.map((item) {
            return item['category_img'].toString() + item['category_info'];
          }).toList();

          return extractedData;
        }
      }
      catch (e)
      {
        print("Data is not in the expected format");
      }
      return [];
    }
}
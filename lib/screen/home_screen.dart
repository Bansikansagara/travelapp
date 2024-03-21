import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/screen/constants.dart';

import 'detail.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  List<String> icons =
  [
    city,
    bus,
    location,
    historical_places,
    devotional_places,
    amusement_parks,
    lakes,
    other_places,
    places_to_see_around,
    cinemas,
    hotels,
    malls,
    travel_guide,
    distances,
    developer
  ];

  List<String> name =
  [
    about,
    howToReach,
    inMap,
    historicalplaces,
    devotionalPlaces,
    amusementParks,
    lakes,
    otherPlaces,
    placesToSeeAround,
    cinema,
    hotel,
    mall,
    travelGuide,
    distance,
    developers
  ];

  List<Color> itemColors = [
    orange,
    grey,
    lgreen,
    bluegrey,
    lgreenAccent,
    brown,
    lblue,
    blue,
    red,
    purple,
    yellow,
    teal,
    blueAccent,
    pinkAccent,
    deepOrange,
  ];

  late List<String> jsonData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints)
          {
            int crossAxisCount = (constraints.maxWidth / 120).floor();

            child:
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: GridView.builder(
                        itemCount: icons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
                          (
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return
                            GestureDetector(
                              onTap: () async
                              {
                                print("name[index]: ${name[index]}");
                                print("icons[index]: ${icons[index]}");

                                if(name[index] == historicalplaces && icons[index] == historical_places)
                                {
                                  print("Historical places tapped!");
                                  jsonData = await viewCategoryData();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => detail(detailName: name[index], jsonData: jsonData,)));
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: itemColors[index],
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 60, // Adjust the height of the image
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(icons[index]),
                                          fit: BoxFit.contain, // Adjust the fit to contain the image within the container
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8), // Adjust the space between image and text
                                    Text(
                                      name[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        }
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<List<String>> viewCategoryData() async {
    print("Calling viewCategoryData");

    final response = await http.get(Uri.parse("https://begrimed-executions.000webhostapp.com/travel_guidance.php/category.php/category_view.php"));
    print("Response: ${response.body}");

    List<dynamic> decodedData = jsonDecode(response.body);
    print("Decoded Data: $decodedData");

    if (decodedData is List) {
      // Check the structure of decodedData and adapt your parsing logic accordingly
      // For example, if decodedData is a list of maps and you want to extract a specific field:
      List<String> extractedData = decodedData.map((item) {
        // Access the relevant field in each item
        // Replace 'fieldName' with the actual field name in your data
        return item['category_name'].toString();
      }).toList();

      return extractedData;
    } else {
      // Handle the case where the data is not in the expected format
      // You can return an empty list or throw an exception based on your use case.
      print("Data is not in the expected format");
      return [];
    }
  }


}

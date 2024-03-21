import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'constants.dart';

class LastPage extends StatefulWidget {
  const LastPage({super.key});

  @override
  State<LastPage> createState() => _LastPageState();
}

class _LastPageState extends State<LastPage>
{
  List<String> last =
  [
    placesAround1,
    placesAround2,
    placesAround3,
    placesAround4,
    placesAround5,
    placesAround6,
    placesAround7,
    placesAround8
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Places To See Around"),
      backgroundColor: Colors.red,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.separated(
               itemBuilder: (BuildContext context, int index)
            {
              return GestureDetector(
                onTap: ()
                {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => secondPage(last[index],)));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  title: Text(last[index], style: TextStyle(color: Colors.red),),
                  trailing: IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => secondPage(secondPageName: page[index]),
                      //   ),
                      // );
                    },
                    icon: Icon(Icons.navigate_next_sharp),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index)
            {
              return Divider(
                color: Colors.black,
                height: 1, // Adjust the height of the divider line
              );
            },
            itemCount: last.length,
          ),
        ),
      ),
    );
  }
}

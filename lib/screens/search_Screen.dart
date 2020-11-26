import 'package:flutter/material.dart';
import 'package:flutter_task/screens/location_screen.dart';
import 'package:flutter_task/services/helper.dart';
import 'package:flutter_task/widgets/serach_widgets.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static final String id = "SearchScreen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool typing = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var data = Provider.of<Helper>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.red,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              "Sign in",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                headerChoice(
                  title: "Location",
                  width: width * 0.2,
                  colour: Colors.redAccent,
                ),
                SizedBox(width: 20.0),
                headerChoice(
                  title: "Account",
                  colour: Colors.grey,
                  width: width * 0.2,
                ),
                SizedBox(width: 20.0),
                headerChoice(
                  title: "Verify",
                  colour: Colors.grey,
                  width: width * 0.2,
                )
              ],
            ),
            SizedBox(height: height * 0.05),
            Row(
              children: [
                Image.asset(
                  "assets/images/search_icon.png",
                ),
                Text(
                  "Set Your Work Location",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20.0),
                hintText: "Enter Your Work Address",
                labelText: "Work Address",
                labelStyle: TextStyle(
                  color: typing ? Colors.red : Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.red,
                  size: 30.0,
                ),
              ),
              onTap: () {
                data.pridictions.clear();
              },
              onChanged: (value) {
                if (value != "") {
                  data.getPlacesList(input: value);
                  setState(() {
                    typing = true;
                  });
                } else if (value == "") {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    data.pridictions.clear();
                    typing = false;
                  });
                }
              },
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(thickness: 1.0);
                },
                padding: EdgeInsets.all(10.0),
                itemCount: data.pridictions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationScreen(
                            placeId: data.pridictions[index].placeId,
                            mainPlaceName: data.pridictions[index].mainText,
                            descriptionPlaceName:
                                data.pridictions[index].description,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.7,
                              child: Text(
                                data.pridictions[index].mainText,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 1, 180, 188),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: width * 0.7,
                              child: Text(
                                data.pridictions[index].description,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

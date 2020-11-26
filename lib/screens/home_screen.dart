import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_task/widgets/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: [
          Image.asset(
            "assets/images/header_home.png",
            width: double.infinity,
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Light",
              style: GoogleFonts.lobster(
                color: Colors.grey.shade700,
                fontSize: 40.0,
                //fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          mealsList(
              height: height, width: width, context: context, name: "light"),
          SizedBox(height: 30.0),
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Best Value",
              style: GoogleFonts.lobster(
                color: Colors.grey.shade700,
                fontSize: 40.0,
                //fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          mealsList(
            height: height,
            width: width,
            context: context,
            name: "best_value",
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Plus",
              style: GoogleFonts.lobster(
                color: Colors.grey.shade700,
                fontSize: 40.0,
                letterSpacing: 2.0,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          mealsList(
              height: height, width: width, context: context, name: "plus"),
        ],
      ),
    );
  }
}

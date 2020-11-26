import 'package:flutter/material.dart';
import 'package:flutter_task/models/meals_details.dart';
import 'package:flutter_task/services/helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Widget mealsList(
    {double height, double width, BuildContext context, String name}) {
  var data = Provider.of<Helper>(context);
  return FutureBuilder(
    future: data.getMealsMenue(menueName: name),
    builder: (context, AsyncSnapshot<List<MealsDetails>> snapshot) {
      if (snapshot.data == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container(
          height: height * 0.5,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Container(width: 10.0);
            },
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    child: Image.network(
                      snapshot.data[index].imageUrl,
                      fit: BoxFit.contain,
                      width: width * 0.4,
                      height: height * 0.3,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    snapshot.data[index].regPrice.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          "plus",
                          style: GoogleFonts.lobster(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        snapshot.data[index].plusPrice.toString(),
                        style: TextStyle(),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: width * 0.2,
                    child: Text(
                      snapshot.data[index].foodName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    snapshot.data[index].restName,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }
    },
  );
}

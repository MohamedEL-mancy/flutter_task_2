import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:flutter_task/widgets/serach_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_task/services/helper.dart';

class LocationScreen extends StatefulWidget {
  static final String id = "LocationScreen";
  final String placeId, mainPlaceName, descriptionPlaceName;
  LocationScreen({this.placeId, this.mainPlaceName, this.descriptionPlaceName});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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
        child: SingleChildScrollView(
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
              Container(
                height: height * 0.7,
                width: double.infinity,
                child: Card(
                    shadowColor: Colors.grey,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            widget.mainPlaceName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: height * 0.3,
                          child: GoogleMap(
                            zoomControlsEnabled: false,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(data.myLat, data.myLong),
                              zoom: 18.0,
                            ),
                            markers: Set.of(Helper.markers.values),
                            onMapCreated: (controller) {
                              data.getPlaceDetails(
                                id: widget.placeId,
                                controller: controller,
                              );
                            },
                            onCameraMoveStarted: () {
                              MarkerId markerId = MarkerId("Home");
                              Marker updateMarker =
                                  Helper.markers[markerId].copyWith(
                                positionParam: LatLng(data.myLat, data.myLong),
                              );
                              setState(() {
                                Helper.markers[markerId] = updateMarker;
                              });
                            },
                            gestureRecognizers:
                                <Factory<OneSequenceGestureRecognizer>>[
                              new Factory<OneSequenceGestureRecognizer>(
                                () => new EagerGestureRecognizer(),
                              ),
                            ].toSet(),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.menu,
                              color: Colors.grey.shade700,
                            ),
                            SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Company Address",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  width: width * 0.7,
                                  child: Text(
                                    widget.descriptionPlaceName,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Company Reception",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Saleh Ahmed \n +02 343 34 3434",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.4, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.red.shade400,
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.26, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Color.fromARGB(255, 1, 180, 188),
                    width: 2.0,
                  ),
                ),
                color: Colors.white,
                child: Text(
                  "Search again",
                  style: TextStyle(
                      color: Color.fromARGB(255, 1, 180, 188), fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

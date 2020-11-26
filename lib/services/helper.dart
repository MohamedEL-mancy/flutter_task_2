import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_task/models/meals_details.dart';
import 'package:flutter_task/models/place_details.dart';
import 'package:flutter_task/models/prediction_places.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Helper extends ChangeNotifier {
  List<PridictionPlacesModel> pridictions = [];
  double myLat = 37.42796133580664, myLong = -122.085749655962;
  void getPlacesList({String input}) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyB-PBPHzbYC90YVPMuEaM7cCMpEhayuZ4I&input=$input&components=country%3Aeg&types=establishment";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var data = decodedData['predictions'];
      var thisList = (data as List)
          .map(
            (elements) => PridictionPlacesModel(
              placeId: elements['place_id'] ?? "",
              mainText: elements['structured_formatting']['main_text'] ?? "",
              description: elements['description'] ?? "",
            ),
          )
          .toList();
      pridictions = thisList;
    }
  }

  static Map<MarkerId, Marker> markers = {};
  void getPlaceDetails({String id, GoogleMapController controller}) async {
    PlaceDetails details;
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyB-PBPHzbYC90YVPMuEaM7cCMpEhayuZ4I&place_id=$id&language=en";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      details = PlaceDetails(
        placeLat: decodedData['result']['geometry']['location']['lat'],
        placeLong: decodedData['result']['geometry']['location']['lng'],
      );
      myLat = details.placeLat;
      myLong = details.placeLong;
      MarkerId markerId = MarkerId("Home");

      Marker myMarker = Marker(
        markerId: markerId,
        position: LatLng(myLat, myLong),
        draggable: true,
      );
      markers[markerId] = myMarker;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(myLat, myLong),
            zoom: 18.0,
          ),
        ),
      );
    }
  }

  Future<List<MealsDetails>> getMealsMenue({String menueName}) async {
    List<MealsDetails> details = [];
    try {
      String url = "http://demo4833373.mockable.io/menu";
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var dataDecoded = jsonDecode(response.body);
        for (var data in dataDecoded[menueName]) {
          var detailsList = MealsDetails(
            imageUrl: data['img'],
            foodName: data['name'],
            restName: data['restaurant'],
            regPrice: data['regular_price'],
            plusPrice: data['plus_price'],
          );
          details.add(detailsList);
        }
      }
    } catch (e) {
      print(e);
    }

    return details;
  }
}

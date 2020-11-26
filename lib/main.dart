import 'package:flutter/material.dart';
import 'package:flutter_task/screens/home_Screen.dart';
import 'package:flutter_task/screens/location_screen.dart';
import 'package:flutter_task/screens/search_Screen.dart';
import 'package:flutter_task/services/helper.dart';
import 'package:provider/provider.dart';

void main() => runApp(FlutterTask());

class FlutterTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Helper(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SearchScreen.id,
        routes: {
          SearchScreen.id: (context) => SearchScreen(),
          LocationScreen.id: (context) => LocationScreen(),
          HomeScreen.id: (context) => HomeScreen(),
        },
      ),
    );
  }
}

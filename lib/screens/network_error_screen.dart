import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoNetWorkScreen extends StatelessWidget{
  const NoNetWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:  Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/no_network.svg",),
            Text("No Network Found",),
            Text("Sorry for the inconvenience. Because of some technical issue we are not able to process the request.Please try any of the below"),
           SizedBox(height: 20,),
            Text("1.Check your internet connection . It should be ON."),
            SizedBox(height: 20,),
            Text("2.Retry after 10 mins or "),
            SizedBox(height: 20,),
            Text("3.Restart the application or"),
            SizedBox(height: 20,),
            Text("4.Restart the mobile."),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

}
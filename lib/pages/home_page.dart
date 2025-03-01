// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mygeoapp/authentication_directory/google_auth.dart';
// import 'package:mygeoapp/pages/sign_up.dart';
// const LatLng currentLocation= LatLng(25.1193,55.3773);
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final purpleColor = Color(0xff6688FF);
//
//   final darkTextColor = Color(0xff1F1A3D);
//
//   final lightTextdcolor = Color(0xff999999);
//
//   final textFieldColor = Color(0xffF5F6FA);
//
//   final borderColor = Color(0xffD9D9D9);


//   Map<String,Marker> _markers={};
//   @override
//   Widget build(BuildContext context) {
//     late GoogleMapController controller;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Navigation',style: TextStyle(color: Colors.blue),),
//         centerTitle: true,
//       ),
//       body: GoogleMap(initialCameraPosition: CameraPosition(target: currentLocation,zoom: 14),onMapCreated: (controller){
//       controller=controller;
//       },
//         markers: _markers.values.toSet(),
//       ),
//       bottomNavigationBar: Container(
//         height: 45.h,
//         child:  GestureDetector(
//           child: Align(
//             alignment: Alignment.centerRight,
//             child: Padding(
//               padding:  EdgeInsets.only(right: 10.0,top: 10.0),
//               child: Text(
//                 "SignOut",
//                 style: TextStyle(
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.w700,
//                   color: purpleColor,
//                 ),
//               ),
//             ),
//           ),
//           onTap: (){

//
//
//   }
//   addMarkar(String id, LatLng location){
//     var marker=Marker(markerId: MarkerId(id),
//       position: location,
//       infoWindow: InfoWindow(
//         title: 'Type off place',
//         snippet: 'Description'
//       )
//     );
//     _markers[id] = marker;
//     setState(() {});
//   }
// }

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mygeoapp/pages/sign_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
// on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

// on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),
  ];

// created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  //signout function
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
  }
  static final GoogleSignIn _googleSignIn = GoogleSignIn(); // <----

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;
  Future<GoogleSignInAccount?> logInWithGmail() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      _user = googleUser;
    }
    return null;
  }

  Future logOut() async {
    await _googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        // on below line we have given title of app
        title: Text("Navigation",style: TextStyle(color: Colors.blue),),
        centerTitle: true,
      ),
      body: Container(
        child: SafeArea(
          // on below line creating google maps
          child: GoogleMap(
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            // on below line we are setting markers on the map
            markers: Set<Marker>.of(_markers),
            // on below line specifying map type.
            mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        ),
      ),
      // on pressing floating action button the camera will take to user current location
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() +" "+value.longitude.toString());

            // marker added for current users location
            _markers.add(
                Marker(
                  markerId: MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(
                    title: 'My Current Location',
                  ),
                )
            );

            // specified current users location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {
            });
          });
        },
        child: Icon(Icons.location_city),
      ),
      bottomNavigationBar: Container(
        height: 40,
        child: GestureDetector(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Sign out',style: TextStyle(color: Colors.blue),),
        ),onTap: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Sign out from your Account?'),
                content: const Text(
                    'We hope you will soon join us again.'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Sign out',
                      style: TextStyle(color: Colors.red),),
                    onPressed: () { logOut();
                    },
                  ),
                ],
              );
            },
          );
        },
        ),
      ),
    );

  }
}

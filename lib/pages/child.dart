
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
class Child extends StatefulWidget {
  @override
  _ChildState createState() => _ChildState();
}
class _ChildState extends State<Child> {
  String sonid="3Tf3uCTcjZVDdvkEB943";
  @override
  void initState() {
    //storeChildLocation();
    super.initState();
    fireStoreInstance.collection("Location").where("sonId",isNotEqualTo:sonid).get().then((value)

    {
      print("lllllllll");
      print(value.docs.first.data()); });


    }
  final fireStoreInstance = FirebaseFirestore.instance;
  var controller = TextEditingController();
  var codeController = TextEditingController();
  String? sonId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHILD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Enter your name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),),
            ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: codeController,
              decoration: InputDecoration(hintText: 'Enter your code',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),),
            ),
            ),
            ElevatedButton(
                onPressed: (){
                  fireStoreInstance.collection("Sons")
                      .where('name', isEqualTo: controller.text)
                      .where('code', isEqualTo:codeController.text)
                      .get()
                      .then((value)
                  { 
                     sonId = value.docs[0].id;
                     print(sonId);
                     //print(value.docs.length);
                     //storeChildLocation();
                  });
                },
                child: const Text('LOGIN'))
          ],
        ),
      ),
    );
  }
storeChildLocation() {
  print(sonId);
  Location location = Location();
  print("Location");
  location.onLocationChanged.listen((LocationData currentLocation) {
    print("lllllllllllll");
     debugPrint(currentLocation.latitude.toString() + "  " + currentLocation.longitude.toString());

     fireStoreInstance.collection('Location').where('sonId',isEqualTo: sonId).get().then((value)

    {

      print(value.docs.length);

      value.docs.first.reference.update( {
      'location':GeoPoint(currentLocation.latitude!,currentLocation.longitude!),
    }); debugPrint("delete success"); });

  });
}
}
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
class Join extends StatefulWidget {
  const Join({Key? key}) : super(key: key);
  @override
  _JoinState createState() => _JoinState();
}
class _JoinState extends State<Join> {
  final nameController = TextEditingController();
  StreamController streamController = StreamController();
  List child = [] ;
  final fireStoreInstance = FirebaseFirestore.instance;
  CollectionReference userRef = FirebaseFirestore.instance.collection("Sons");
  var Id;
  Future <void> getData() async {
    QuerySnapshot querySnapshot = await userRef.get();
    for (var element in querySnapshot.docs) {
      setState(() {
        child.add(element.data());
      });
      //print(child);
    }

  }
  Future <String> getCurrentUser() async {
    FirebaseAuth instance =FirebaseAuth.instance;
    final User user = await instance.currentUser!;
    final  uid = user.uid;
    print(uid);
    // Similarly we can get email as well final uemail = user.email; print(uemail);
    return uid;
  }
  late Stream stream ;
  @override
  void initState() {
    getData();
    //Id = getCurrentUser();
    //print(Id);
    Id=getCurrentUser();
    print (FirebaseFirestore.instance.collection('Sons').where('parent_id',isEqualTo: Id).snapshots());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: const Text('Join children'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter your child's name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),)
              ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton  (
                  onPressed: () async {
                    fireStoreInstance.collection("Sons").add({
                      "name" : nameController.text,
                      "parent_id": await Id,
                      "code":randomNumeric(10),
                    } ).then((value){
                      fireStoreInstance.collection('Location').add({
                        "location": GeoPoint(0,0),
                        "sonId": value.id,
                      });
                    });

                    },
                  child: const Text('Join  Child '),
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), ),),),
                const SizedBox(width: 10 ,),
                ElevatedButton  (
                  onPressed: () async {
                    //https://stackoverflow.com/questions/56341378/delete-a-document-in-firebase-when-you-know-the-field-value
                    //You can fetch the document first and then delete the document
                    fireStoreInstance.collection("Sons").where('name' , isEqualTo: nameController.text).get().then((value)
                    { value.docs.first.reference.delete(); debugPrint("delete success"); });
                    },
                  child: const Text('Delete Child'),
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),),),),
              ],
            ),
            const SizedBox(height: 10,),
            const Text("List of Children",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 , color:Colors.black ),),
            Expanded(
              child:StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Sons').snapshots(),
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(snapshot.hasError){ return const Text("No DATA");}
                  if(snapshot.connectionState == ConnectionState.waiting){ return const Text("LOADING");}
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i){
                        return child.isEmpty ?  const CircularProgressIndicator(): ListTile(
                          leading: Image.asset("assets/images/Child_icon.png"),
                          trailing: const Text("Location"),
                          title: Text(child[i]['name'],style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20 , color:Colors.black ),),
                          subtitle: const Text("code",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 , color:Colors.black ),),
                        );
                        });
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

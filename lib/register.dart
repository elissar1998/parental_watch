import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parental_watch_backend/pages/login_parent.dart';
import 'package:parental_watch_backend/pages/selection_home_page.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  late String _email,_password,_name;
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create an account"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Image.asset('assets/images/family.jpg',fit: BoxFit.fill,),
                //const SizedBox(height: 10,),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),),
                  ),
                  onChanged: (value){
                    setState(() {
                      _name=value;
                    });
                  },
                ),
                const SizedBox(height: 10,),
                TextField(
                  decoration:InputDecoration(
                    hintText: 'Email',
                    suffixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),),
                  ),
                  onChanged: (value){
                    setState(() {
                      _email=value;
                    });
                  },
                ),
                const SizedBox(height: 10,),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: const Icon(Icons.visibility_off),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),),
                  ),
                  onChanged: (value){
                    setState(() {
                      _password=value;
                    });
                  },
                ),
                const SizedBox(height: 10,),
                RaisedButton(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.blue,
                    child: const Text('Register',style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: (){
                      try {
                        //UserCredential credential =
                        instance.createUserWithEmailAndPassword(email: _email, password: _password).then(
                                (value) {
                                  FirebaseFirestore.instance.collection('Parent').doc(value.user!.uid).set(
                                      {
                                        "name": _name,
                                        "password":_password,
                                        "email": value.user!.email,
                                      }
                                      );
                                } ) ;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  LoginScreen()),);
                      } on FirebaseAuthException catch (e) {
                        // debugPrint("exception");
                        if (e.code == 'weak-password') {
                          // snakBar is toast
                          debugPrint("weak-password");
                        }
                      }
                    }
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
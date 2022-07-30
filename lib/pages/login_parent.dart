import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../join.dart';
import '../register.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  late String _email,_password;
  FirebaseAuth instance =FirebaseAuth.instance;
  getCurrentUser() async {
    final User user = await instance.currentUser!;
    final uid = user.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    print(uid);
    //print(uemail);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login To My Account'),
        actions: [ IconButton(onPressed: (){
          instance.signOut();
          //print("Logout");
        }, icon: const Icon(Icons.logout)),],
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: "Email",
                    suffixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),)
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),)),
                onChanged: (value){
                  setState(() {
                    _password=value;
                  });
                },
              ),
              const SizedBox(height: 10,),
              RaisedButton(
                color: Colors.blue,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                child: const Text("Login"),
                onPressed: () async { try{
                  UserCredential credential = await instance.signInWithEmailAndPassword(email: _email, password: _password);
                  final  userid  = await credential.user!.uid;

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Join()));
                } on FirebaseAuthException catch(e){
                 // print(e.code);

                }},
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account',
                    style: TextStyle(fontWeight: FontWeight.bold,),
                  ),
                  const SizedBox(width: 10,),
                  FlatButton(
                    color: Colors.blue,
                    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Register(),));
                    },
                    child: const Text('Register',style: TextStyle(fontWeight: FontWeight.bold,),),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}

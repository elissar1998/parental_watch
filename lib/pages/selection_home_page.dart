import 'package:flutter/material.dart';
import 'package:parental_watch_backend/pages/login_parent.dart';
import 'package:parental_watch_backend/pages/child.dart';
class SelectionHomePage extends StatefulWidget {
  @override
  _SelectionHomePageState createState() => _SelectionHomePageState();
}

class _SelectionHomePageState extends State<SelectionHomePage> {
  bool _k=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal[50],



        child: Center(
          child: SingleChildScrollView(


            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


               const Text("Who use this application ?",style: TextStyle(color: Colors.black54,
                  fontSize: 23, fontStyle: FontStyle.italic,



                ),),
                const SizedBox(
                  height: 100,

                ),
                const Padding(
                  padding:  EdgeInsets.all(8.0),),


                Image.asset("assets/images/parent_icon.png",height: 60,width: 60,),


                GestureDetector(

                  child: Container(
                    color:  Colors.blueGrey[200],
                    padding: const EdgeInsets.all(8),
                    // Change button text when light changes state.
                    child: TextButton(

                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        setState(() {
                          _k=false;

                        });
                      },
                      child: const Text('Parent'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,

                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),),



                Image.asset("assets/images/Child_icon.png",height: 60,width: 60),

                GestureDetector(


                  child: Container(
                      color: Colors.yellow.shade600,
                      padding: const EdgeInsets.all(8),
                      // Change button text when light changes state.
                      child: TextButton(
                        child: Text("Child"),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),

                        onPressed: () {
                          setState(() {
                            _k=true;
                          });
                        },

                      )


                  ),


                ),
                const SizedBox(
                  height: 30,

                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),),
                MaterialButton(
                  onPressed: (){
                    if (_k==false ){Navigator.push(context, MaterialPageRoute(builder:(context) =>const LoginScreen()));}

                    if (_k== true ){Navigator.push(context, MaterialPageRoute(builder:(context) =>Child()));}
                  },
                  child:
                  const Text("Continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),
                  ),
                  minWidth: 200,
                  height: 48,
                  color: Color(0xFF0865A8),
                  shape: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
}




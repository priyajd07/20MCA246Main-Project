import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix/flutter_flow/flutter_flow_util.dart';
import 'package:netflix/login/signup.dart';
import '../auth/google_auth.dart';
import '../bottom_bar/bottom_bar.dart';
import '../main.dart';

String emailId=' ';

class Login extends StatefulWidget {
  const Login({Key ,key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController email;
  late TextEditingController password;
  @override
  void initState() {
    email=TextEditingController();
    password=TextEditingController();
    // TODO: implement initState
    super.initState();
  }
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: SizedBox()),
                Image.asset('assets/images/m.png',height: MediaQuery.of(context).size.height*0.1,),

                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    // color: Colors.blue,
                    // child: Image.asset('assets/fli.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Email',
                          icon: Icon(Icons.person),
                        ),
                        controller: email,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          icon:Icon(Icons.lock),
                            hintText: 'Password'
                        ),
                        controller: password,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                    onTap: () async {

                      var user;
                      try {
                        user  = await auth.signInWithEmailAndPassword(
                            email: email.text,
                            password: password.text
                        );
                      }
                      catch(err){
                        return showSnackbar(context, 'Incorrect Email or Password');
                      }
                      if (user == null) {
                        return showSnackbar(context, 'Incorrect Email or Password');
                      }
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomBar(),
                        ),
                            (r) => false,
                      );

                    },
                    child: Container(
                      decoration: BoxDecoration(
                         color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: MediaQuery.of(context).size.height*0.07,
                      width: MediaQuery.of(context).size.width*0.7,

                      child: Center(child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                    ),
                  ),
                ),

                 Padding(
                   padding: const EdgeInsets.only(top: 40),
                   child: InkWell(
                     onTap: () async {
                       final user = await signInWithGoogle(context);
                       if (user == null) {
                         return;
                       }
                       await Navigator.pushAndRemoveUntil(
                         context,
                         MaterialPageRoute(
                           builder: (context) =>
                               BottomBar(),
                         ),
                             (r) => false,
                       );
                     },
                     child: Container(
                      width: 50,
                      height: 50,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network('https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png'),
                ),
                   ),
                 ),
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t Have Account?',style: TextStyle(color: Colors.white),),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                      },
                      child: Text('Sign Up',style: TextStyle(
                          fontWeight: FontWeight.bold,color: Colors.white
                      ),),
                    ),
                  ],),
                Expanded(child: SizedBox()),

              ],
            ),
          ),
        ],
      ),

    );
  }
}

//@dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netflix/auth/auth_util.dart';
import 'package:netflix/flutter_flow/flutter_flow_util.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'auth/firebase_user_provider.dart';
import 'bottom_bar/bottom_bar.dart';
import 'login/login.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'login/user.dart';
User currentUserModel;
RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: showLoading ? const Duration(minutes: 30) : const Duration(seconds: 4),
        content: Row(
          children: [
            if (showLoading)
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],),
      ),
    );
}


var h;
var w;
var primaryColor=Colors.red;

String loggedInAs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Stream<AdminQrcodeFirebaseUser> userStream;
  AdminQrcodeFirebaseUser initialUser;
  final authUserSub = authenticatedUserStream.listen((_) {});

  void initState() {
    super.initState();
    userStream = adminQrcodeFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Flix',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  initialUser == null
          ? const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: Color(0xFF60DEF4),
          ),
        ),
      )
          : currentUser.loggedIn
          ? BottomBar()
          : Login(),

    );
  }
}


Future<File> downloadFile(String url,String name,BuildContext context) async {
  final appStorage =await getExternalStorageDirectory();
  final file=File('${appStorage.path}/$name');
  print(appStorage.path);
  try{
    final response=await Dio().get(
        url,
        options:Options(
          responseType:ResponseType.bytes,
          followRedirects:false,
          receiveTimeout:0,

        )
    );
    print('bbbbbbbbbbbbbbbbbbb');
    final raf=file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
     showSnackbar(context, '$name downloaded successfully');
    print(file);
    print(file.path);
    print('path printed');
    btnController.success();
    return file;

  }catch(e){
    print('done');
    return null;
  }
}
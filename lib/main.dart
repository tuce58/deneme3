import 'package:deneme3/screens/mentor_profil.dart';
import 'package:deneme3/screens/mentor_screen.dart';
import 'package:deneme3/screens/ogrenci_profil.dart';
import 'package:deneme3/screens/ogrenci_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'mentor_profile_screen.dart'; // MentorProfileScreenNoAppointment için gerekli dosya

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'mentor_profile_screen.dart'; // Mevcut MentorProfileScreenNoAppointment dosyası

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentör Öğrenci Uygulaması',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => MentorProfileScreen(mentorId: "cr35KC6uqQqYW0tvRfUg"),
        '/editProfile': (context) => MentorFormPage(mentorId: "cr35KC6uqQqYW0tvRfUg"),
      },
    );
  }
}

/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentör Öğrenci Uygulaması',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => StudentProfileScreen(studentId:"IwzdI3IBOl2Ub0OSF5VQ"),
        '/editProfile': (context) => StudentFormPage(studentId: 'IwzdI3IBOl2Ub0OSF5VQ',),
      },
    );
  }
}

*/
/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlatıyoruz.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentör Bilgi Sistemi',
      home: StudentFormPage(),
    );
  }
}
*/

/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlatıyoruz.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentor Bilgi Sistemi',
      home: MentorFormPage(),
    );
  }
}
*/
/*

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlatıyoruz.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentör Bilgi Sistemi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MentorFormPage(mentorId: '',), // Burayı MentorFormPage olarak değiştiriyoruz.
    );
  }
}
*/
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
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
      home: const MovieAppHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MovieAppHome extends StatefulWidget {
  const MovieAppHome({Key? key}) : super(key: key);

  @override
  State<MovieAppHome> createState() => _MovieAppHomeState();
}

class _MovieAppHomeState extends State<MovieAppHome> {

  //ini untuk buat list item movie
  var listMovie = [
    {"Ant Man", "image1.png"},
    {"Avenger", "image2.png"},
    {"Buzz Lighyear", "image3.png"},
    {"Harry Potter", "image4.png"},
    {"Minios", "image5.png"},
    {"Soekarno", "image6.png"},
    {"Spiderman", "image7.png"},
  ];


  List<Container> daftarFilm = [];

  //method untuk generate list
  dataListMovie(){
    for(var i = 0; i<listMovie.length; i++){
      final Set<String> film = listMovie[i];
      final String title = film.elementAt(0);
      final String images = film.elementAt(1);

      daftarFilm.add(
        Container(
          padding: const EdgeInsets.all(10), //space kiri kanan atas bawah
          child: Card(
            child: InkWell(
              onTap: (){},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: AssetImage("gambar/$images"),
                    fit: BoxFit.cover,
                    height: 150,
                    width: 150,
                  )
                ],
              ),

            ),
          ),
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Text('Hello Ini Page Movie App'),
      ),
    );
  }
}


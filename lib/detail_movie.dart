import 'package:flutter/material.dart';

class DetailPageMovie extends StatefulWidget {
  //constructor penampung data
  final String title;
  final String image;

  const DetailPageMovie({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  State<DetailPageMovie> createState() => _DetailPageMovieState();
}

class _DetailPageMovieState extends State<DetailPageMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Image(
                image: AssetImage(widget.image),
                height: 300,
                fit: BoxFit.cover,
              ),
              Padding(padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,
                        color: Color(0XFFdbcd07),),
                        SizedBox(width: 5,),
                        Text('5',
                        style: TextStyle(fontSize: 24),)
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 5,),
              const Menu(),
              Padding(padding: EdgeInsets.all(8),
                child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
              )

            ],
          )
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.favorite, color: Colors.grey,),
            SizedBox(height: 5,),
            Text('Favorite')
          ],
        ),
        Column(
          children: [
            Icon(Icons.share, color: Colors.grey,),
            SizedBox(height: 5,),
            Text('Share')
          ],
        ),
        Column(
          children: [
            Icon(Icons.bookmark, color: Colors.grey,),
            SizedBox(height: 5,),
            Text('Bookmart')
          ],
        ),
      ],
    );
  }
}

